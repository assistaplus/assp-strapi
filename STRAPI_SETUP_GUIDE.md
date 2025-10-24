# Strapi CMS Setup Guide - Multi-Tenant Integration

## 🎯 Current Status
- ✅ **Strapi CMS**: Running at `https://backend-cms-strapi-production.up.railway.app/`
- ✅ **Database**: Connected to PostgreSQL
- ✅ **Multi-tenant middleware**: Created and configured
- ✅ **API endpoints**: Custom tenant content routes created
- ✅ **Content SDK**: Updated with Strapi integration

## 🔧 Next Steps Required

### 1. Access Strapi Admin Panel
1. Go to: `https://backend-cms-strapi-production.up.railway.app/admin`
2. Create your first admin user account
3. Complete the initial setup

### 2. Create Content Types (Manual Setup Required)

#### A. Tenant Content Type
1. Go to **Content-Type Builder** in admin panel
2. Create new **Collection Type**:
   - **Display name**: `Tenant`
   - **API ID**: `tenant`
3. Add these fields:
   ```
   - slug (Text, Required, Unique)
   - name (Text, Required)
   - type (Text, Required)
   - industry (Text)
   - size (Text)
   - headquarters (Text)
   - regions (JSON)
   - domains (JSON)
   - branding (JSON)
   - locales (JSON)
   - timezone (Text)
   - contractValue (Number)
   - contractStartDate (DateTime)
   - contractEndDate (DateTime)
   - isActive (Boolean)
   - primaryContact (Text)
   - contactEmail (Email)
   - contactPhone (Text)
   - description (Long text)
   - tags (JSON)
   - customFields (JSON)
   ```

#### B. Learning Activity Content Type
1. Create new **Collection Type**:
   - **Display name**: `Learning Activity`
   - **API ID**: `learning-activity`
2. Add these fields:
   ```
   - title (Text, Required)
   - description (Long text)
   - activityType (Text, Required)
   - duration (Number)
   - difficulty (Text)
   - activityStatus (Text)
   - startDate (DateTime)
   - endDate (DateTime)
   - completionDate (DateTime)
   - score (Number)
   - metadata (JSON)
   - tenantId (Text, Required)
   ```

#### C. Assessment Template Content Type
1. Create new **Collection Type**:
   - **Display name**: `Assessment Template`
   - **API ID**: `assessment-template`
2. Add these fields:
   ```
   - name (Text, Required)
   - description (Long text)
   - category (Text)
   - framework (Text)
   - questions (JSON)
   - scoring (JSON)
   - timeLimit (Number)
   - isActive (Boolean)
   - tenantId (Text, Required)
   ```

#### D. Course Content Content Type
1. Create new **Collection Type**:
   - **Display name**: `Course Content`
   - **API ID**: `course-content`
2. Add these fields:
   ```
   - title (Text, Required)
   - slug (Text, Required, Unique)
   - description (Long text)
   - content (Rich text)
   - category (Text)
   - level (Text)
   - duration (Number)
   - isPublished (Boolean)
   - publishDate (DateTime)
   - metadata (JSON)
   - tenantId (Text, Required)
   ```

#### E. User Profile Content Type
1. Create new **Collection Type**:
   - **Display name**: `User Profile`
   - **API ID**: `user-profile`
2. Add these fields:
   ```
   - clerkId (Text, Required, Unique)
   - firstName (Text)
   - lastName (Text)
   - email (Email, Required)
   - role (Text)
   - department (Text)
   - skills (JSON)
   - goals (JSON)
   - preferences (JSON)
   - tenantId (Text, Required)
   ```

### 3. Configure API Permissions
1. Go to **Settings** → **Users & Permissions** → **Roles**
2. For **Public** role, enable:
   - `find` and `findOne` for all content types
3. For **Authenticated** role, enable:
   - All permissions for all content types

### 4. Test Multi-Tenant Setup
1. Create a test tenant entry
2. Create some sample content
3. Test the API endpoints:
   ```
   GET /api/tenant-content
   GET /api/tenant-content/branding
   POST /api/tenant-content
   ```

### 5. Generate API Token
1. Go to **Settings** → **API Tokens**
2. Create new token:
   - **Name**: `Frontend Integration`
   - **Token type**: `Full access`
   - **Token duration**: `Unlimited`
3. Copy the generated token for frontend use

## 🔗 Frontend Integration

### Update Environment Variables
Add to your frontend `.env.local`:
```bash
NEXT_PUBLIC_STRAPI_URL=https://backend-cms-strapi-production.up.railway.app
STRAPI_API_TOKEN=your_generated_token_here
```

### Use Content SDK
```typescript
import { ContentSDK } from '@/lib/content-sdk';

const contentSDK = new ContentSDK({
  baseURL: process.env.NEXT_PUBLIC_STRAPI_URL,
  tenantId: 'dubai-future-skills',
  apiKey: process.env.STRAPI_API_TOKEN
});

// Get Strapi content
const content = await contentSDK.getStrapiContent('course-content');
```

## 🚨 Troubleshooting

### Content Types Not Showing
- Ensure you've created them through the admin panel
- Check that the API token has proper permissions
- Verify the content types are published

### API Endpoints Not Working
- Check that the custom routes are properly configured
- Verify the tenant isolation middleware is active
- Test with proper authentication headers

### Database Connection Issues
- Verify PostgreSQL connection in Strapi settings
- Check that the database schema is properly migrated
- Ensure all required environment variables are set

## 📞 Support
- Strapi Documentation: https://docs.strapi.io/
- Railway Deployment: https://docs.railway.com/
- Multi-tenant Architecture: See our `MULTI_TENANT_DEPLOYMENT_GUIDE.md`
