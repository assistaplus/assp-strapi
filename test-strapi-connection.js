#!/usr/bin/env node

import fetch from 'node-fetch';

const STRAPI_URL = 'https://backend-cms-strapi-production.up.railway.app';
const API_TOKEN = process.env.STRAPI_TOKEN || 'YOUR_TOKEN_HERE';

async function testConnection() {
  console.log('🔍 Testing Strapi Connection...\n');
  
  try {
    // Test 1: Basic connectivity
    console.log('1️⃣ Testing basic connectivity...');
    const healthResponse = await fetch(`${STRAPI_URL}/`);
    console.log(`   Status: ${healthResponse.status} ${healthResponse.statusText}`);
    
    if (healthResponse.status === 302) {
      console.log('   ✅ Strapi is running (redirecting to admin)');
    }
    
    // Test 2: API endpoint
    console.log('\n2️⃣ Testing API endpoint...');
    const apiResponse = await fetch(`${STRAPI_URL}/api/`);
    console.log(`   Status: ${apiResponse.status} ${apiResponse.statusText}`);
    
    const apiData = await apiResponse.json();
    console.log('   Response:', JSON.stringify(apiData, null, 2));
    
    // Test 3: API with token (if provided)
    if (API_TOKEN && API_TOKEN !== 'YOUR_TOKEN_HERE') {
      console.log('\n3️⃣ Testing API with token...');
      const authResponse = await fetch(`${STRAPI_URL}/api/articles`, {
        headers: {
          'Authorization': `Bearer ${API_TOKEN}`,
          'Content-Type': 'application/json'
        }
      });
      console.log(`   Status: ${authResponse.status} ${authResponse.statusText}`);
      
      if (authResponse.ok) {
        const authData = await authResponse.json();
        console.log('   ✅ API token working');
        console.log('   Data:', JSON.stringify(authData, null, 2));
      } else {
        console.log('   ⚠️ API token may need permissions configuration');
      }
    } else {
      console.log('\n3️⃣ Skipping token test (no token provided)');
      console.log('   To test with token: STRAPI_TOKEN=your_token node test-strapi-connection.js');
    }
    
    // Test 4: Content types
    console.log('\n4️⃣ Testing content types...');
    const contentTypesResponse = await fetch(`${STRAPI_URL}/api/content-manager/content-types`);
    console.log(`   Status: ${contentTypesResponse.status} ${contentTypesResponse.statusText}`);
    
    if (contentTypesResponse.ok) {
      const contentTypes = await contentTypesResponse.json();
      console.log('   ✅ Content types accessible');
      console.log('   Available types:', contentTypes.data?.map(ct => ct.uid) || 'None');
    }
    
  } catch (error) {
    console.error('❌ Connection test failed:', error.message);
    console.error('   This could indicate:');
    console.error('   - Strapi instance is down');
    console.error('   - Network connectivity issues');
    console.error('   - CORS configuration problems');
  }
}

// Run the test
testConnection();
