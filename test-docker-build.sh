#!/bin/bash

# Test Docker Build for Strapi
echo "🧪 Testing Strapi Docker build locally..."

# Check if Docker is running
if ! docker info &> /dev/null; then
    echo "❌ Docker is not running. Please start Docker first."
    exit 1
fi

# Build the Docker image
echo "🔨 Building Docker image..."
docker build -t strapi-test .

if [ $? -eq 0 ]; then
    echo "✅ Docker build successful!"
    echo "🚀 Image built as 'strapi-test'"
    echo ""
    echo "To test the image locally:"
    echo "docker run -p 1337:1337 --env-file .env strapi-test"
    echo ""
    echo "To clean up:"
    echo "docker rmi strapi-test"
else
    echo "❌ Docker build failed!"
    echo "Check the error messages above."
    exit 1
fi
