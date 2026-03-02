#!/bin/bash
set -e

echo "=== Installing Docker ==="
sudo apt-get update -qq
sudo apt-get install -y ca-certificates curl gnupg git
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update -qq
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
sudo usermod -aG docker ubuntu
sudo systemctl enable docker
sudo systemctl start docker

echo "=== Cloning repo ==="
cd /home/ubuntu
if [ -d "supabase-backend" ]; then
  cd supabase-backend && git pull
else
  git clone https://github.com/KAMESH-RAVICHANDRAN/supabase-backend.git
  cd supabase-backend
fi

echo "=== Writing .env ==="
cat > .env << 'ENVEOF'
POSTGRES_PASSWORD=94dacc6173143fcc3440f1fc7c9a9c0e
JWT_SECRET=lYkNzYQQ3iXwrLyc0mpwjrjoASsKUfUVyPwegSl6
ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYW5vbiIsImlzcyI6InN1cGFiYXNlIiwiaWF0IjoxNzcyMzgzNDc1LCJleHAiOjE5MzAwNjM0NzV9.9KFHVIy7viHx2gBCcjhVdCoLPLc_8UnzHmdE3mJGzQg
SERVICE_ROLE_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoic2VydmljZV9yb2xlIiwiaXNzIjoic3VwYWJhc2UiLCJpYXQiOjE3NzIzODM0NzUsImV4cCI6MTkzMDA2MzQ3NX0.aigmHcvYGLknGRlwjU_PC0Y_dfI3ZAJ3H2j-UqZc-_U
DASHBOARD_USERNAME=supabase
DASHBOARD_PASSWORD=8074dfbe7e802ac76e90da0b65bc50f6
SITE_URL=https://supabase-ennuthu-studio.vercel.app
API_EXTERNAL_URL=http://56.228.35.139:8000
SUPABASE_PUBLIC_URL=http://56.228.35.139:8000
SECRET_KEY_BASE=uxhoa/bMdePfmxmZz05SnT+sDiHm55xvRavhwAkk41Mhk4MBRldNar7lh5aPPw99
VAULT_ENC_KEY=1e08250b60ae20e214b07a3279aa50bd
PG_META_CRYPTO_KEY=8Lqc1T4X1bp100ROpjSySrqfNiyt+5dq
LOGFLARE_PUBLIC_ACCESS_TOKEN=keLpyd+LVXMz6snxMslFSU+6IYNAae8i
LOGFLARE_PRIVATE_ACCESS_TOKEN=M2evtLixHp2Qj0LHwxI+e1M4qrm4CDoH
S3_PROTOCOL_ACCESS_KEY_ID=78e8d46e3241ea5bb04199295331991d
S3_PROTOCOL_ACCESS_KEY_SECRET=5b49f7dd8b29f0961a1f19408f87699a3b68ad63ea4b30b07a9fe9b2f39fd7fc
MINIO_ROOT_USER=supabase-s3
MINIO_ROOT_PASSWORD=33158fe035f519189435f52072b201ee
POSTGRES_HOST=db
POSTGRES_DB=postgres
POSTGRES_PORT=5432
POOLER_TENANT_ID=1244573a626f017a
DOCKER_SOCKET_LOCATION=/var/run/docker.sock
FUNCTIONS_VERIFY_JWT=false
KONG_HTTP_PORT=8000
KONG_HTTPS_PORT=8443
JWT_EXPIRY=3600
ENABLE_EMAIL_SIGNUP=true
ENABLE_EMAIL_AUTOCONFIRM=false
ENABLE_PHONE_SIGNUP=false
ENABLE_PHONE_AUTOCONFIRM=false
ENABLE_ANONYMOUS_USERS=false
DISABLE_SIGNUP=false
SMTP_ADMIN_EMAIL=admin@example.com
SMTP_HOST=
SMTP_PORT=587
SMTP_USER=
SMTP_PASS=
SMTP_SENDER_NAME=Supabase
MAILER_URLPATHS_INVITE=/auth/v1/verify
MAILER_URLPATHS_CONFIRMATION=/auth/v1/verify
MAILER_URLPATHS_RECOVERY=/auth/v1/verify
MAILER_URLPATHS_EMAIL_CHANGE=/auth/v1/verify
ADDITIONAL_REDIRECT_URLS=
PGRST_DB_SCHEMAS=public,storage,graphql_public
POOLER_PROXY_PORT_TRANSACTION=6543
POOLER_DB_POOL_SIZE=10
POOLER_DEFAULT_POOL_SIZE=20
POOLER_MAX_CLIENT_CONN=100
STORAGE_TENANT_ID=stub
REGION=eu-north-1
GLOBAL_S3_BUCKET=stub
IMGPROXY_ENABLE_WEBP_DETECTION=true
STUDIO_DEFAULT_ORGANIZATION=Default Organization
STUDIO_DEFAULT_PROJECT=Default Project
ENVEOF

echo "=== Starting Supabase (this takes 2-3 minutes) ==="
sudo docker compose up -d

echo ""
echo "========================================="
echo "Done! Supabase is starting up."
echo "Check status: sudo docker compose ps"
echo "API ready at: http://56.228.35.139:8000"
echo "========================================="
