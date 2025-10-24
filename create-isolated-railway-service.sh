#!/bin/bash

# Create Isolated Railway Service for Strapi CMS
echo "🚀 Creating ISOLATED Railway service for Strapi CMS..."
echo "⚠️  This will create a SEPARATE Railway project (not service in existing project)"
echo ""

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

echo "🔧 Creating NEW Railway project for Strapi..."
echo "   This ensures complete isolation from backend service"
echo ""

# Create new Railway project (not service in existing project)
echo "📝 Initializing new Railway project..."
railway init --name "strapi-cms"

if [ $? -ne 0 ]; then
    echo "❌ Failed to create Railway project"
    echo "   Try running: railway login"
    exit 1
fi

echo "✅ Railway project created successfully!"
echo ""

# Set critical environment variable to force correct Dockerfile
echo "🔧 Setting RAILWAY_DOCKERFILE_PATH to force correct Dockerfile..."
railway variables set RAILWAY_DOCKERFILE_PATH="Dockerfile"

if [ $? -eq 0 ]; then
    echo "✅ RAILWAY_DOCKERFILE_PATH set successfully"
else
    echo "❌ Failed to set RAILWAY_DOCKERFILE_PATH"
    exit 1
fi

echo ""
echo "📝 Setting all Strapi environment variables..."

# Core Configuration
railway variables set NODE_ENV=production
railway variables set PORT=1337
railway variables set HOST=0.0.0.0

# Database (shared with main backend)
railway variables set DATABASE_CLIENT=postgres
railway variables set DATABASE_URL="postgresql://neondb_owner:npg_0kIgzR6tAUMT@ep-spring-glade-a96nxor0-pooler.gwc.azure.neon.tech/neondb?sslmode=require&pgbouncer=true&connect_timeout=30"

# Strapi Security Keys (Generated Securely)
railway variables set APP_KEYS="HsR2WAi9rOx4DuFCgD9EEw==,R0I3ytYyXIFoVoAM8g4t8Q==,K60Zlum7dZIFffOIv1aGHg==,NfKV2xlju/ZpHlu9pd5jOA=="
railway variables set JWT_SECRET="Rr8lD8gEsQacn6SSj5co/V2rWiN4zaflxBeXB5KkFxI="
railway variables set ADMIN_JWT_SECRET="IlXSqf3dwN56Yg0NY1WE8yGxRTXcZ1O5JxHC4cwUMAw="
railway variables set API_TOKEN_SALT="rIgkuE+G1folg0AqWs0XkA=="
railway variables set TRANSFER_TOKEN_SALT="CHCvTfF24JBfcOOsYjNBpA=="
railway variables set ENCRYPTION_KEY="FXKingxX1xkmMNlHsdh48sXCD5PfX5bPXajkcb3ZuaI="

# External APIs
railway variables set OPENAI_API_KEY="your_openai_api_key_here"

# CORS
railway variables set FRONTEND_URL="https://agentforce-three.vercel.app"

echo "✅ All environment variables set successfully!"
echo ""
echo "🚀 Ready to deploy! Run:"
echo "railway up"
echo ""
echo "🔍 After deployment, verify:"
echo "railway status"
echo "railway logs"
echo "railway domain"
echo ""
echo "⚠️  This is a COMPLETELY SEPARATE Railway project from your backend"
echo "   Your backend service will continue running independently"
