#!/bin/bash

# Verify Strapi Database Connection
echo "🔍 Verifying Strapi database connection..."

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

echo "📊 Checking Railway logs for database connection..."
echo ""
echo "🔍 Look for these SUCCESS indicators:"
echo "✅ 'Connecting to the postgres database...'"
echo "✅ 'Server started in development mode' or 'Server started in production mode'"
echo "✅ No 'sqlite' references"
echo "✅ No database connection errors"
echo ""
echo "❌ FAILURE indicators to watch for:"
echo "❌ 'Error: connect ECONNREFUSED'"
echo "❌ 'sqlite' mentioned anywhere"
echo "❌ Database connection timeouts"
echo ""

# Show recent logs
echo "📋 Recent Strapi logs:"
railway logs --tail 50

echo ""
echo "🔧 To check environment variables:"
echo "railway variables"
echo ""
echo "🔧 To check database schema in Neon:"
echo "1. Go to your Neon dashboard"
echo "2. Check the 'public' schema"
echo "3. Look for Strapi tables (users, roles, permissions, etc.)"
