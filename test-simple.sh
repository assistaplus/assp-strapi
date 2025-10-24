#!/bin/bash

echo "🔍 Testing Strapi Connection..."

STRAPI_URL="https://backend-cms-strapi-production.up.railway.app"

echo "1️⃣ Testing basic connectivity..."
curl -I "$STRAPI_URL/" 2>/dev/null | head -1

echo -e "\n2️⃣ Testing API endpoint..."
curl -s "$STRAPI_URL/api/" | jq . 2>/dev/null || curl -s "$STRAPI_URL/api/"

echo -e "\n3️⃣ Testing content types..."
curl -s "$STRAPI_URL/api/content-manager/content-types" | jq . 2>/dev/null || curl -s "$STRAPI_URL/api/content-manager/content-types"

echo -e "\n4️⃣ Testing with API token (if provided)..."
if [ ! -z "$STRAPI_TOKEN" ]; then
    curl -s -H "Authorization: Bearer $STRAPI_TOKEN" "$STRAPI_URL/api/articles" | jq . 2>/dev/null || curl -s -H "Authorization: Bearer $STRAPI_TOKEN" "$STRAPI_URL/api/articles"
else
    echo "   No STRAPI_TOKEN provided. Set it with: export STRAPI_TOKEN=your_token"
fi

echo -e "\n✅ Test complete!"
