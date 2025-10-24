# Strapi Troubleshooting Guide

## Current Issues Identified

### 1. Content Types Not Accessible via API
**Problem**: API returns 404 for content types
**Root Cause**: Content types may not be published or API permissions not configured

### 2. MCP Tool Authentication
**Problem**: MCP tool can't create entries
**Root Cause**: May need API token authentication

### 3. Database Schema Alignment
**Problem**: Need to ensure Strapi content types match our Prisma schema
**Root Cause**: Content types need to be properly configured with relationships

## Solutions

### Step 1: Check Strapi Admin Panel
1. Go to `https://backend-cms-strapi-production.up.railway.app/admin`
2. Navigate to **Content-Type Builder**
3. Verify content types are listed:
   - Tenant
   - Learning Activity
   - Assessment Template
   - Course Content
   - User Profile

### Step 2: Configure API Permissions
1. Go to **Settings** → **Users & Permissions** → **Roles**
2. For **Public** role, enable:
   - `find` and `findOne` for all content types
3. For **Authenticated** role, enable:
   - All permissions for all content types

### Step 3: Generate API Token
1. Go to **Settings** → **API Tokens**
2. Create new token:
   - **Name**: `MCP Integration`
   - **Token type**: `Full access`
   - **Token duration**: `Unlimited`
3. Copy the generated token

### Step 4: Test API Endpoints
```bash
# Test with API token
curl -X GET https://backend-cms-strapi-production.up.railway.app/api/content-types \
  -H "Authorization: Bearer YOUR_API_TOKEN"

# Test specific content type
curl -X GET https://backend-cms-strapi-production.up.railway.app/api/tenants \
  -H "Authorization: Bearer YOUR_API_TOKEN"
```

### Step 5: Configure MCP Tool
Update MCP tool configuration with API token:
```javascript
// In MCP tool configuration
const strapiConfig = {
  baseURL: 'https://backend-cms-strapi-production.up.railway.app',
  apiToken: 'YOUR_API_TOKEN_HERE'
};
```

## Database Schema Alignment

### Required Content Types (Matching Prisma Schema):

#### 1. Tenant
- **Fields**: slug, name, type, industry, size, headquarters, regions, domains, branding, locales, timezone, contractValue, contractStartDate, contractEndDate, isActive, primaryContact, contactEmail, contactPhone, description, tags, customFields
- **Relations**: users, content, settings, learningActivities, auditLogs

#### 2. Learning Activity
- **Fields**: title, description, activityType, activityStatus, progress, score, startDate, completedDate, dueDate, duration, difficulty, metadata, tenantId
- **Relations**: tenant, user

#### 3. Assessment Template
- **Fields**: name, description, category, framework, questions, scoring, timeLimit, isActive, difficulty, metadata, tenantId
- **Relations**: tenant

#### 4. Course Content
- **Fields**: title, slug, description, content, category, level, duration, isPublished, publishDate, tags, metadata, tenantId
- **Relations**: tenant

#### 5. User Profile
- **Fields**: clerkId, firstName, lastName, email, role, department, skills, goals, preferences, careerLevel, experience, metadata, tenantId
- **Relations**: tenant

## API Gateway Recommendations

### Option 1: Kong Gateway (Recommended)
- **Multi-tenant support** with tenant isolation
- **Rate limiting** and throttling
- **Authentication** integration (Clerk, JWT)
- **Load balancing** and health checks

### Option 2: AWS API Gateway
- **Serverless** and scalable
- **Built-in authentication** (Cognito, JWT)
- **Rate limiting** and caching
- **Lambda integration** for custom logic

### Option 3: Nginx Plus
- **High-performance** and cost-effective
- **Reverse proxy** capabilities
- **Load balancing** and caching
- **SSL termination** and security

## Next Steps

1. **Verify Strapi Admin Access** - Check content types in admin panel
2. **Configure API Permissions** - Set up proper access controls
3. **Generate API Token** - For MCP tool authentication
4. **Test API Endpoints** - Verify all endpoints are working
5. **Choose API Gateway** - Implement gateway solution
6. **Integrate Clerk** - Set up authentication
7. **Test End-to-End** - Verify complete workflow
