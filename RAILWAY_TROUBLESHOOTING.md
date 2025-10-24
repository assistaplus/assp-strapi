# Railway Deployment Troubleshooting Guide

## 🚨 Common Issues and Solutions

### Issue 1: Docker Build Failure - "node_modules not found"
**Error:** `ERROR: failed to build: failed to solve: failed to compute cache key: failed to calculate checksum of ref alq661kuow9y7urposnz7s8ot::vs37cb5vnswxumzzu7wt9r8d7: "/app/backend/node_modules": not found`

**Solution:** 
- ✅ Created optimized `Dockerfile` for Strapi
- ✅ Added `.dockerignore` to exclude unnecessary files
- ✅ Updated `railway.json` to use Dockerfile builder

### Issue 2: Port Conflicts
**Error:** `The port 1337 is already used by another application`

**Solution:**
```bash
# Kill existing processes
pkill -f strapi
pkill -f node

# Or use different port locally
PORT=1338 npm run develop
```

### Issue 3: Environment Variables Missing
**Error:** `Missing apiToken.salt` or similar

**Solution:**
```bash
# Run the setup script
./setup-railway-env.sh

# Or set manually
railway variables set API_TOKEN_SALT="rIgkuE+G1folg0AqWs0XkA=="
```

## 🔧 Deployment Steps

### 1. Clean Deployment
```bash
cd /home/litvagent/hr-ai-marketplace/apps/backend-cms/strapi

# Login to Railway
railway login

# Initialize new service
railway init

# Set environment variables
./setup-railway-env.sh

# Deploy
railway up
```

### 2. Alternative: Use Railway Dashboard
1. Go to Railway dashboard
2. Create new project
3. Connect GitHub repository
4. Select `apps/backend-cms/strapi` as root directory
5. Set environment variables manually
6. Deploy

## 🐛 Debugging Commands

```bash
# Check Railway service status
railway status

# View deployment logs
railway logs

# Get service URL
railway domain

# Check environment variables
railway variables

# Connect to service shell
railway shell
```

## 📋 Pre-Deployment Checklist

- [ ] All environment variables set
- [ ] Dockerfile exists and is valid
- [ ] .dockerignore configured
- [ ] package.json has correct scripts
- [ ] Database connection string valid
- [ ] Security keys generated and set

## 🚀 Post-Deployment Verification

1. **Check Health:**
   ```bash
   curl https://your-railway-url.com/admin
   ```

2. **Access Admin Panel:**
   - Go to `https://your-railway-url.com/admin`
   - Create admin user
   - Configure content types

3. **Test API:**
   ```bash
   curl https://your-railway-url.com/api
   ```

## 🔄 Rollback Strategy

If deployment fails:
```bash
# Check previous deployments
railway deployments

# Rollback to previous version
railway rollback

# Or redeploy with fixes
railway up
```

## 📞 Support

- Railway Documentation: https://docs.railway.app/
- Strapi Documentation: https://docs.strapi.io/
- Railway Discord: https://discord.gg/railway
