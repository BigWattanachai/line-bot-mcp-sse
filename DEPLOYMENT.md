# Deployment Guide for LINE Bot MCP Server

This guide will help you deploy the LINE Bot MCP Server on a Linux server.

## Prerequisites

- Node.js v20 or later
- npm or pnpm
- Git
- A LINE Official Account with Messaging API enabled
- Channel Access Token from the LINE Developer Console
- User ID of a LINE user to test with

## Step 1: Clone the Repository

```bash
git clone https://github.com/line/line-bot-mcp-server.git
cd line-bot-mcp-server
```

## Step 2: Install Dependencies

Using npm:
```bash
npm install
```

Or using pnpm:
```bash
pnpm install
```

## Step 3: Build the Project

```bash
npm run build
```

This will create a `dist` folder with the compiled JavaScript files.

## Step 4: Install Supergateway

Supergateway is needed to expose the MCP server as a web service:

```bash
npm install -g supergateway
```

## Step 5: Run the Server

You can run the server with the following command:

```bash
export CHANNEL_ACCESS_TOKEN="your_channel_access_token"
export DESTINATION_USER_ID="your_user_id"

supergateway \
  --stdio "node $(pwd)/dist/index.js" \
  --port 8000 \
  --outputTransport sse
```

Replace `your_channel_access_token` and `your_user_id` with your actual values.

## Step 6: Expose the Server (Optional)

If you want to expose your server to the internet, you can use a reverse proxy like Nginx or use a service like ngrok:

```bash
# Install ngrok
npm install -g ngrok

# Expose the server
ngrok http 8000
```

## Running as a Systemd Service

For a more permanent deployment, you can create a systemd service:

1. Create a service file:

```bash
sudo nano /etc/systemd/system/line-bot-mcp.service
```

2. Add the following content:

```
[Unit]
Description=LINE Bot MCP Server
After=network.target

[Service]
Type=simple
User=your_username
WorkingDirectory=/path/to/line-bot-mcp-server
ExecStart=/usr/bin/supergateway --stdio "node /path/to/line-bot-mcp-server/dist/index.js" --port 8000 --outputTransport sse
Environment="CHANNEL_ACCESS_TOKEN=your_channel_access_token"
Environment="DESTINATION_USER_ID=your_user_id"
Restart=on-failure

[Install]
WantedBy=multi-user.target
```

3. Enable and start the service:

```bash
sudo systemctl enable line-bot-mcp
sudo systemctl start line-bot-mcp
```

4. Check the status:

```bash
sudo systemctl status line-bot-mcp
```

## Using Docker

You can also run the server using Docker:

1. Build the Docker image using the simple Dockerfile:

```bash
docker build -t line-bot-mcp-server -f Dockerfile .
```

2. Run the container:

```bash
docker run -p 8000:8000 \
  -e CHANNEL_ACCESS_TOKEN="your_channel_access_token" \
  -e DESTINATION_USER_ID="your_user_id" \
  line-bot-mcp-server
```

3. Alternatively, use docker-compose for easier deployment:

```bash
# Set environment variables first
export CHANNEL_ACCESS_TOKEN="your_channel_access_token"
export DESTINATION_USER_ID="your_user_id"

# Run with docker-compose
docker-compose up -d
```

## Troubleshooting

If you encounter issues:

1. Check that your environment variables are set correctly
2. Verify that the Node.js version is 20 or later
3. Make sure the port 8000 is not being used by another application
4. Check the logs for any error messages

For more information, refer to the [LINE Messaging API documentation](https://developers.line.biz/en/docs/messaging-api/).
