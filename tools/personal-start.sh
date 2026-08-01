#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO_ROOT"

if ! command -v docker >/dev/null 2>&1; then
  echo "Docker is not installed. Install and open Docker Desktop, then run this script again."
  exit 1
fi

if ! docker info >/dev/null 2>&1; then
  echo "Docker is installed but not running. Open Docker Desktop, then run this script again."
  exit 1
fi

if [ ! -f .env ]; then
  bash tools/deploy.sh
  awk '{ if ($0 ~ /^AP_TELEMETRY_ENABLED=/) print "AP_TELEMETRY_ENABLED=false"; else print }' .env > .env.tmp
  mv .env.tmp .env
  echo "Created a private local .env file with generated secrets."
fi

mkdir -p cache
docker compose up -d

echo
echo "Activepieces is starting. Open http://localhost:8080"
echo "Check status with: docker compose ps"
echo "Stop it with: docker compose down"
