# Multi-stage build for production
FROM node:18-bullseye-slim as packages

WORKDIR /app
COPY package.json yarn.lock ./
COPY packages packages

# Install dependencies
RUN yarn install --frozen-lockfile --network-timeout 300000

FROM node:18-bullseye-slim as build

# Install system dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    python3 \
    python3-pip \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install techdocs dependencies
RUN pip3 install mkdocs-techdocs-core==1.2.3

WORKDIR /app

# Copy dependencies
COPY --from=packages /app/node_modules ./node_modules
COPY --from=packages /app/package.json ./package.json
COPY --from=packages /app/yarn.lock ./yarn.lock

# Copy source
COPY . .

# Build the backend
RUN yarn build:backend --config ../../app-config.yaml --config ../../app-config.production.yaml

FROM node:18-bullseye-slim

# Install runtime dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    python3 \
    python3-pip \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Install techdocs dependencies
RUN pip3 install mkdocs-techdocs-core==1.2.3

# Create app user
RUN groupadd --gid 1001 --system backstage && \
    useradd --uid 1001 --system --gid backstage --home /app --create-home --shell /bin/bash backstage

WORKDIR /app

# Copy built application
COPY --from=build --chown=backstage:backstage /app/packages/backend/dist/bundle.tar.gz ./
RUN tar xzf bundle.tar.gz && rm bundle.tar.gz

# Copy configuration
COPY --chown=backstage:backstage app-config*.yaml ./

USER 1001

EXPOSE 7007

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:7007/api/catalog/health || exit 1

CMD ["node", "packages/backend", "--config", "app-config.yaml", "--config", "app-config.production.yaml"]
