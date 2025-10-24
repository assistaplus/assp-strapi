# Railway Service Isolation - Critical Fix

## 🚨 Problem Identified
Railway is using the backend's `Dockerfile.railway` instead of Strapi's `Dockerfile`, causing:
```
COPY --from=deps /app/backend/node_modules ./backend/node_modules
```
This line doesn't exist in our Strapi Dockerfile!

## 🔧 Solution: Force Service Isolation

### Step 1: Create Completely Isolated Railway Service
```bash
cd /home/litvagent/hr-ai-marketplace/apps/backend-cms/strapi

# Create NEW Railway project (not service in existing project)
railway login
railway init --name "strapi-cms"
```

### Step 2: Set Critical Environment Variables
```bash
# Force Railway to use Strapi's Dockerfile
railway variables set RAILWAY_DOCKERFILE_PATH="Dockerfile"

# Set all Strapi environment variables
./setup-railway-env.sh
```

### Step 3: Verify Service Isolation
```bash
# Check Railway is using correct directory
railway status

# Verify Dockerfile path
railway variables | grep RAILWAY_DOCKERFILE_PATH
```

## 🚨 Alternative: Manual Railway Dashboard Setup

If CLI doesn't work, use Railway Dashboard:

1. **Create NEW Project** (not service in existing project)
2. **Connect GitHub Repository**
3. **Set Root Directory**: `apps/backend-cms/strapi/`
4. **Set Environment Variables**:
   - `RAILWAY_DOCKERFILE_PATH=Dockerfile`
   - All other Strapi variables from setup script
5. **Deploy**

## 🔍 Verification Steps

After deployment, check:
- Build logs show "Using Dockerfile" (not "Using Detected Dockerfile")
- No `--from=deps` errors
- Build uses Strapi's simple Dockerfile
- Service runs on port 1337

## 🚨 Critical Points

- **MUST** create separate Railway project for Strapi
- **MUST** set `RAILWAY_DOCKERFILE_PATH=Dockerfile`
- **MUST** set root directory to `apps/backend-cms/strapi/`
- **DO NOT** use existing backend project
