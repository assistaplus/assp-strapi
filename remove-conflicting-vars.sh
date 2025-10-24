#!/bin/bash

# Remove Conflicting Railway Environment Variables
echo "🔧 Removing conflicting Railway environment variables..."

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

echo "🗑️ Removing RAILWAY_DOCKERFILE_PATH variable..."
railway variables --delete RAILWAY_DOCKERFILE_PATH

echo "✅ Conflicting variables removed!"
echo ""
echo "📋 Next steps:"
echo "1. Update railway.toml with absolute Dockerfile path"
echo "2. Fix Dockerfile build context"
echo "3. Remove root-level Railway files"
echo "4. Test deployment"
