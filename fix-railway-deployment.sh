#!/bin/bash

# Fix Railway Deployment - Force Dockerfile Usage
echo "🔧 Fixing Railway deployment to use Dockerfile..."

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

echo "🚀 Setting RAILWAY_DOCKERFILE_PATH to force Dockerfile usage..."
railway variables --set "RAILWAY_DOCKERFILE_PATH=Dockerfile"

if [ $? -eq 0 ]; then
    echo "✅ RAILWAY_DOCKERFILE_PATH set successfully!"
    echo ""
    echo "🚀 Now deploying with Dockerfile..."
    railway up
else
    echo "❌ Failed to set RAILWAY_DOCKERFILE_PATH"
    echo "   Try setting it manually in Railway Dashboard:"
    echo "   RAILWAY_DOCKERFILE_PATH = Dockerfile"
    exit 1
fi
