#!/bin/bash

# Strapi Railway Deployment Script
echo "🚀 Deploying Strapi to Railway..."

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

# Build the project
echo "📦 Building Strapi..."
npm run build

# Deploy to Railway
echo "🚀 Deploying to Railway..."
railway up

echo "✅ Deployment complete!"
echo "🌐 Check your deployment status with: railway status"
echo "📊 View logs with: railway logs"
echo "🔗 Get your domain with: railway domain"
