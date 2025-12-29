# Simple Backstage Dockerfile
FROM node:18-bullseye-slim

# Install system dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    python3 \
    python3-pip \
    build-essential \
    git \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Install techdocs dependencies
RUN pip3 install mkdocs-techdocs-core==1.2.3

# Create app user
RUN groupadd --gid 1001 --system backstage && \
    useradd --uid 1001 --system --gid backstage --home /app --create-home --shell /bin/bash backstage

WORKDIR /app

# Copy source code
COPY --chown=backstage:backstage . .

# Install dependencies and build
RUN cd app && npm install --legacy-peer-deps && npm run build

USER 1001

EXPOSE 7007

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:7007/api/catalog/health || exit 1

CMD ["node", "app/dist/packages/backend", "--config", "app/app-config.yaml", "--config", "app/app-config.production.yaml"]
