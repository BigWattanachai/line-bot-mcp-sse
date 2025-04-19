FROM node:20-alpine

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install all dependencies including dev dependencies for build
RUN npm ci

# Install supergateway globally
RUN npm install -g supergateway

# Copy source code and build
COPY . .
RUN npm run build

# Clean up dev dependencies after build to reduce image size
RUN npm ci --omit=dev

# Create a startup script
COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

EXPOSE 8000

CMD ["/bin/sh", "/app/start.sh"]
