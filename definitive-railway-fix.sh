#!/bin/bash

# DEFINITIVE Railway Fix - Based on Perplexity Analysis
echo "🚀 Applying DEFINITIVE Railway fix for Strapi deployment..."

# Check if Railway CLI is installed
if ! command -v railway &> /dev/null; then
    echo "❌ Railway CLI not found. Please install it first:"
    echo "npm install -g @railway/cli"
    exit 1
fi

# Check if logged in to Railway
if ! railway whoami &> /dev/null; then
    echo "❌ Not logged in to Railway. Please run:"
    echo "railway login"
    exit 1
fi

echo "🔧 Step 1: Removing conflicting environment variables..."
railway variables --delete RAILWAY_DOCKERFILE_PATH 2>/dev/null || echo "Variable not found (good)"

echo "✅ Step 1 complete: Conflicting variables removed"
echo ""

echo "🔧 Step 2: Setting all required environment variables..."

# Core Configuration
railway variables --set "NODE_ENV=production"
railway variables --set "HOST=0.0.0.0"
railway variables --set "PORT=1337"

# Database (PostgreSQL - Production Ready)
railway variables --set "DATABASE_CLIENT=postgres"
railway variables --set "DATABASE_URL=postgresql://neondb_owner:npg_0kIgzR6tAUMT@ep-spring-glade-a96nxor0-pooler.gwc.azure.neon.tech/neondb?sslmode=require&pgbouncer=true&connect_timeout=30"

# Strapi Security Keys (Generated Securely)
railway variables --set "APP_KEYS=HsR2WAi9rOx4DuFCgD9EEw==,R0I3ytYyXIFoVoAM8g4t8Q==,K60Zlum7dZIFffOIv1aGHg==,NfKV2xlju/ZpHlu9pd5jOA=="
railway variables --set "JWT_SECRET=Rr8lD8gEsQacn6SSj5co/V2rWiN4zaflxBeXB5KkFxI="
railway variables --set "ADMIN_JWT_SECRET=IlXSqf3dwN56Yg0NY1WE8yGxRTXcZ1O5JxHC4cwUMAw="
railway variables --set "API_TOKEN_SALT=rIgkuE+G1folg0AqWs0XkA=="
railway variables --set "TRANSFER_TOKEN_SALT=CHCvTfF24JBfcOOsYjNBpA=="
railway variables --set "ENCRYPTION_KEY=FXKingxX1xkmMNlHsdh48sXCD5PfX5bPXajkcb3ZuaI="

# External APIs
railway variables --set "OPENAI_API_KEY=your_openai_api_key_here"

# CORS
railway variables --set "FRONTEND_URL=https://agentforce-three.vercel.app"

echo "✅ Step 2 complete: All environment variables set"
echo ""

echo "🔧 Step 3: Making a trivial commit to trigger rebuild..."
# Add a comment to package.json to trigger rebuild
sed -i '1i\# Trigger rebuild - Railway fix' /home/litvagent/hr-ai-marketplace/apps/backend-cms/strapi/package.json

echo "✅ Step 3 complete: Rebuild trigger created"
echo ""

echo "🚀 Step 4: Deploying with fixed configuration..."
railway up

echo ""
echo "✅ DEFINITIVE FIX APPLIED!"
echo ""
echo "🔍 Verification steps:"
echo "1. Check build logs for: 'Building from Dockerfile at /apps/backend-cms/strapi/Dockerfile'"
echo "2. Verify no 'COPY --from=deps' errors"
echo "3. Confirm Strapi starts successfully"
echo "4. Test admin panel at: https://your-railway-url.com/admin"
echo ""
echo "📊 Monitor deployment with:"
echo "railway logs"
echo "railway status"
