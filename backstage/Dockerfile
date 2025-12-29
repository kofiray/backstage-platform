FROM node:18-bullseye-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    python3 python3-pip build-essential git curl && \
    pip3 install mkdocs-techdocs-core==1.2.3 && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY app/package.json ./
RUN npm install --legacy-peer-deps

COPY app/ ./
RUN npm run build

EXPOSE 7007
CMD ["node", "backend.js"]
