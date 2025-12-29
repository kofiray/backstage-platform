# Multi-stage build for production
# Multi-stage build for Backstage
FROM node:18-bullseye-slim as build

# Install system dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    python3 \
    python3-pip \
    build-essential \
    git \
    && rm -rf /var/lib/apt/lists/*

# Install techdocs dependencies
RUN pip3 install mkdocs-techdocs-core==1.2.3

WORKDIR /app

# Copy package files
COPY package.json yarn.lock ./
COPY packages/backend/package.json ./packages/backend/
COPY app/package.json ./app/
COPY plugins/signoz/package.json ./plugins/signoz/

# Install dependencies
RUN yarn install --frozen-lockfile --network-timeout 600000

# Copy source code
COPY . .

# Build the application
RUN yarn build:backend

# Production image
FROM node:18-bullseye-slim

# Install runtime dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    python3 \
    python3-pip \
    curl \
    && rm -rf /var/lib/apt/lists/* \
    && pip3 install mkdocs-techdocs-core==1.2.3

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
