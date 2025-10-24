import path from 'path';

export default ({ env }) => {
  const client = env('DATABASE_CLIENT', 'postgres');

  const connections = {
    mysql: {
      connection: {
        host: env('DATABASE_HOST', 'localhost'),
        port: env.int('DATABASE_PORT', 3306),
        database: env('DATABASE_NAME', 'strapi'),
        user: env('DATABASE_USERNAME', 'strapi'),
        password: env('DATABASE_PASSWORD', 'strapi'),
        ssl: env.bool('DATABASE_SSL', false) && {
          key: env('DATABASE_SSL_KEY', undefined),
          cert: env('DATABASE_SSL_CERT', undefined),
          ca: env('DATABASE_SSL_CA', undefined),
          capath: env('DATABASE_SSL_CAPATH', undefined),
          cipher: env('DATABASE_SSL_CIPHER', undefined),
          rejectUnauthorized: env.bool('DATABASE_SSL_REJECT_UNAUTHORIZED', true),
        },
      },
      pool: { min: env.int('DATABASE_POOL_MIN', 2), max: env.int('DATABASE_POOL_MAX', 10) },
    },
    postgres: {
      connection: {
        connectionString: env('DATABASE_URL'),
        host: env('DATABASE_HOST', 'localhost'),
        port: env.int('DATABASE_PORT', 5432),
        database: env('DATABASE_NAME', 'strapi'),
        user: env('DATABASE_USERNAME', 'strapi'),
        password: env('DATABASE_PASSWORD', 'strapi'),
        ssl: env.bool('DATABASE_SSL', false) && {
          key: env('DATABASE_SSL_KEY', undefined),
          cert: env('DATABASE_SSL_CERT', undefined),
          ca: env('DATABASE_SSL_CA', undefined),
          capath: env('DATABASE_SSL_CAPATH', undefined),
          cipher: env('DATABASE_SSL_CIPHER', undefined),
          rejectUnauthorized: env.bool('DATABASE_SSL_REJECT_UNAUTHORIZED', true),
        },
        schema: env('DATABASE_SCHEMA', 'public'),
        // Connection timeout settings for better reliability
        connectTimeout: env.int('DATABASE_CONNECT_TIMEOUT', 30000), // 30 seconds
        requestTimeout: env.int('DATABASE_REQUEST_TIMEOUT', 60000), // 60 seconds
        idleTimeout: env.int('DATABASE_IDLE_TIMEOUT', 300000), // 5 minutes
        // Connection retry settings
        retryDelayMs: env.int('DATABASE_RETRY_DELAY', 1000), // 1 second
        maxRetries: env.int('DATABASE_MAX_RETRIES', 3),
      },
      pool: { 
        min: env.int('DATABASE_POOL_MIN', 2), 
        max: env.int('DATABASE_POOL_MAX', 10),
        // Pool timeout settings
        acquireTimeoutMillis: env.int('DATABASE_ACQUIRE_TIMEOUT', 30000), // 30 seconds
        createTimeoutMillis: env.int('DATABASE_CREATE_TIMEOUT', 30000), // 30 seconds
        destroyTimeoutMillis: env.int('DATABASE_DESTROY_TIMEOUT', 5000), // 5 seconds
        idleTimeoutMillis: env.int('DATABASE_IDLE_TIMEOUT', 300000), // 5 minutes
        reapIntervalMillis: env.int('DATABASE_REAP_INTERVAL', 1000), // 1 second
        createRetryIntervalMillis: env.int('DATABASE_CREATE_RETRY_INTERVAL', 200), // 200ms
      },
    },
    sqlite: {
      connection: {
        filename: path.join(__dirname, '..', '..', env('DATABASE_FILENAME', '.tmp/data.db')),
      },
      useNullAsDefault: true,
    },
  };

  return {
    connection: {
      client,
      ...connections[client],
      acquireConnectionTimeout: env.int('DATABASE_CONNECTION_TIMEOUT', 60000),
      // Additional timeout settings for better reliability
      timeout: env.int('DATABASE_TIMEOUT', 30000), // 30 seconds
      connectionTimeoutMillis: env.int('DATABASE_CONNECTION_TIMEOUT_MILLIS', 30000), // 30 seconds
    },
  };
};
