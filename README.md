# Supabase Backend (Self-Hosted)

This repo contains the full Supabase self-hosted backend stack using Docker Compose.

## Services included
- **Kong** - API gateway (port 8000)
- **GoTrue** - Auth server
- **PostgREST** - REST API for Postgres
- **Realtime** - WebSocket server
- **Storage** - Object storage
- **pg-meta** - Postgres metadata API
- **Logflare/Analytics** - Log analytics
- **Postgres** - Database
- **Supavisor** - Connection pooler
- **imgproxy** - Image transformations

## Deploy (Recommended: VPS)

`sh
git clone https://github.com/KAMESH-RAVICHANDRAN/supabase-backend.git
cd supabase-backend
cp .env.example .env
# Fill in secrets - run utils/generate-keys.sh to generate JWT/API keys
nano .env
docker compose up -d
# API available at http://YOUR_SERVER_IP:8000
`

## Deploy on Railway

1. New Railway project -> New Service -> GitHub Repo -> this repo
2. Add all vars from .env.example in Railway Variables tab
3. Expose port 8000 as public endpoint
4. Set SUPABASE_PUBLIC_URL to your Railway domain

## Generate API Keys

`sh
chmod +x utils/generate-keys.sh
./utils/generate-keys.sh
`

## Connect to Vercel Frontend

Set these in Vercel Studio project Environment Variables:
- SUPABASE_URL=https://your-backend-domain
- SUPABASE_PUBLIC_URL=https://your-backend-domain
- NEXT_PUBLIC_GOTRUE_URL=https://your-backend-domain/auth/v1
- SUPABASE_ANON_KEY=<anon-key from .env>
- SUPABASE_SERVICE_KEY=<service-role-key from .env>
- STUDIO_PG_META_URL=https://your-backend-domain/pg
