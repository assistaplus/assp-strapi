/**
 * Strapi Security Configuration
 * 
 * Fixes Content Security Policy issues for marketplace images
 */

module.exports = {
  contentSecurityPolicy: {
    useDefaults: true,
    directives: {
      'connect-src': ["'self'", 'https:'],
      'img-src': [
        "'self'",
        'data:',
        'blob:',
        'https://market-assets.strapi.io',
        'https://strapi-ai-staging.s3.us-east-1.amazonaws.com',
        'https://strapi-ai-production.s3.us-east-1.amazonaws.com',
        'https://market-api.strapi.io',
        'https://cdn.jsdelivr.net',
        'https://unpkg.com'
      ],
      'media-src': [
        "'self'",
        'data:',
        'blob:',
        'https://market-assets.strapi.io'
      ],
      'script-src': [
        "'self'",
        "'unsafe-inline'",
        "'unsafe-eval'",
        'https://cdn.jsdelivr.net',
        'https://unpkg.com'
      ],
      'style-src': [
        "'self'",
        "'unsafe-inline'",
        'https://fonts.googleapis.com',
        'https://cdn.jsdelivr.net'
      ],
      'font-src': [
        "'self'",
        'https://fonts.gstatic.com',
        'https://cdn.jsdelivr.net'
      ]
    },
    upgradeInsecureRequests: null,
  },
};
