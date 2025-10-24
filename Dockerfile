# Strapi CMS Dockerfile - Simple and Clean
FROM node:20-alpine

# Install system dependencies
RUN apk add --no-cache libc6-compat

# Set working directory
WORKDIR /app

# Copy package files from Strapi directory (relative to repo root)
COPY apps/backend-cms/strapi/package*.json ./

# Install dependencies
RUN npm ci --only=production && npm cache clean --force

# Copy Strapi application code (relative to repo root)
COPY apps/backend-cms/strapi .

# Build the Strapi application
RUN npm run build

# Create necessary directories
RUN mkdir -p /app/public/uploads

# Create non-root user
RUN addgroup --system --gid 1001 nodejs && \
    adduser --system --uid 1001 strapi

# Set ownership
RUN chown -R strapi:nodejs /app

# Switch to non-root user
USER strapi

# Expose port
EXPOSE 1337

# Set environment variables
ENV NODE_ENV=production
ENV PORT=1337
ENV HOST=0.0.0.0

# Start the application
CMD ["npm", "start"]
