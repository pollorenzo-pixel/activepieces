# Personal Activepieces Deployment

This branch keeps Activepieces close to upstream and changes only what is useful for a single-person installation:

- one Activepieces container running both the app and one worker
- PostgreSQL and Redis
- generated local secrets
- telemetry disabled when the personal start script creates `.env`
- no custom UI, authentication system, or enterprise feature replacement

## 1. Install the prerequisite

Install and open Docker Desktop on your Mac.

## 2. Clone this deployment branch

```bash
git clone --branch agent/personal-deploy --single-branch https://github.com/pollorenzo-pixel/activepieces.git
cd activepieces
```

## 3. Start Activepieces

```bash
bash tools/personal-start.sh
```

The first start downloads the containers and may take several minutes. Open:

```text
http://localhost:8080
```

Create your owner account in the browser.

## Everyday commands

Check the containers:

```bash
docker compose ps
```

Stop Activepieces without deleting its data:

```bash
docker compose down
```

Start it again:

```bash
docker compose up -d
```

View recent logs:

```bash
docker compose logs --tail=100
```

## Backup

Create a database backup before upgrades or important changes:

```bash
docker compose exec -T postgres pg_dump -U postgres activepieces > activepieces-backup.sql
```

Keep both `activepieces-backup.sql` and your local `.env` file somewhere private. Never commit `.env` because it contains encryption keys and passwords.

## Workflow naming

Use a clear prefix rather than building a custom project system:

```text
PERSONAL | Morning briefing
SERENE | New Shopify order
YUME | Supplier follow-up
KIJU | Catering enquiry
VEXIS | Customer onboarding
SMALLBIZ | Daily founder briefing
```

## Scope rule

Add a custom feature only when an actual workflow cannot be completed using the existing builder, integrations, webhooks, forms, AI steps, or a small code step.
