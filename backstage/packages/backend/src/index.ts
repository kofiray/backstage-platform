import { createBackend } from '@backstage/backend-defaults';

const backend = createBackend();

// Auth plugin
backend.add(import('@backstage/plugin-auth-backend'));
backend.add(import('@backstage/plugin-auth-backend/alpha'));

// Catalog plugin
backend.add(import('@backstage/plugin-catalog-backend/alpha'));

// Scaffolder plugin
backend.add(import('@backstage/plugin-scaffolder-backend/alpha'));

// TechDocs plugin
backend.add(import('@backstage/plugin-techdocs-backend/alpha'));

// Kubernetes plugin
backend.add(import('@backstage/plugin-kubernetes-backend/alpha'));

// Search plugin
backend.add(import('@backstage/plugin-search-backend/alpha'));
backend.add(import('@backstage/plugin-search-backend-module-pg/alpha'));

// Proxy plugin
backend.add(import('@backstage/plugin-proxy-backend/alpha'));

// App backend plugin
backend.add(import('@backstage/plugin-app-backend/alpha'));

backend.start();
