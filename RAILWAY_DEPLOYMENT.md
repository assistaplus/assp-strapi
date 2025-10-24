# Strapi Railway Deployment Guide

## Prerequisites
1. Railway CLI installed (`railway --version`)
2. Railway account and login (`railway login`)

## Environment Variables for Railway
Set these in Railway dashboard or via CLI:

```bash
# Core Configuration
NODE_ENV=production
PORT=1337
HOST=0.0.0.0

# Database (using shared PostgreSQL)


# External APIs
OPENAI_API_KEY=your_openai_api_key_here

# CORS
FRONTEND_URL=https://agentforce-three.vercel.app
```

## Deployment Steps

1. **Login to Railway:**
   ```bash
   railway login
   ```

2. **Create new service:**
   ```bash
   cd /home/litvagent/hr-ai-marketplace/apps/backend-cms/strapi
   railway init
   ```

3. **Set environment variables:**
   ```bash
   railway variables set NODE_ENV=production
   railway variables set PORT=1337
   railway variables set HOST=0.0.0.0
   railway variables set DATABASE_CLIENT=postgres
   railway variables set DATABASE_URL="postgresql://neondb_owner:npg_0kIgzR6tAUMT@ep-spring-glade-a96nxor0-pooler.gwc.azure.neon.tech/neondb?sslmode=require&pgbouncer=true&connect_timeout=30"
   railway variables set APP_KEYS="myKeyA,myKeyB,myKeyC,myKeyD"
   railway variables set JWT_SECRET="strapi-jwt-secret-key-2024-production-ready"
   railway variables set ADMIN_JWT_SECRET="strapi-admin-jwt-secret-key-2024-production-ready"
   railway variables set API_TOKEN_SALT="strapi-api-token-salt-2024-secure"
   railway variables set TRANSFER_TOKEN_SALT="strapi-transfer-token-salt-2024-secure"
   railway variables set ENCRYPTION_KEY="strapi-encryption-key-2024-32-chars-long"
   railway variables set OPENAI_API_KEY="your_openai_api_key_here"
   railway variables set FRONTEND_URL="https://agentforce-three.vercel.app"
   ```

4. **Deploy:**
   ```bash
   railway up
   ```

5. **Get deployment URL:**
   ```bash
   railway domain
   ```

## Post-Deployment
1. Access admin panel at `https://your-railway-url.com/admin`
2. Create admin user
3. Configure content types
4. Test API endpoints

## Monitoring
- Check logs: `railway logs`
- Check status: `railway status`
- View metrics in Railway dashboard
