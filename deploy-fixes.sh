#!/bin/bash

echo "🚀 Deploying Strapi fixes to Railway..."

# Navigate to Strapi directory
cd /home/litvagent/hr-ai-marketplace/apps/backend-cms/strapi

echo "📁 Current directory: $(pwd)"

# Check if we're in a git repository
if [ ! -d ".git" ]; then
    echo "⚠️ Not in a git repository, initializing..."
    git init
    git remote add origin https://github.com/assistaplus/assp-strapi.git
fi

# Add all changes
echo "📝 Adding changes to git..."
git add .

# Commit changes
echo "💾 Committing changes..."
git commit -m "Fix: CSP headers, CORS, and API configuration for Railway deployment

- Added comprehensive CSP headers for Strapi marketplace
- Configured CORS for multiple frontend domains
- Added API configuration for better performance
- Created connection test script

Fixes:
- 500 errors from marketplace API
- CSP violations in browser console
- MCP server connection issues"

# Push to Railway
echo "🚀 Deploying to Railway..."
railway up

echo "✅ Deployment initiated!"
echo "📊 Check Railway dashboard for deployment status"
echo "🔗 Admin panel: https://backend-cms-strapi-production.up.railway.app/admin"
echo "🧪 Test API: https://backend-cms-strapi-production.up.railway.app/api/"
