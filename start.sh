#!/bin/sh

# Print environment variables (without values for security)
echo "Environment variables check:"
echo "CHANNEL_ACCESS_TOKEN present: $([ ! -z \"$CHANNEL_ACCESS_TOKEN\" ] && echo 'Yes' || echo 'No')"
echo "DESTINATION_USER_ID present: $([ ! -z \"$DESTINATION_USER_ID\" ] && echo 'Yes' || echo 'No')"

# Check if CHANNEL_ACCESS_TOKEN is set
if [ -z "$CHANNEL_ACCESS_TOKEN" ]; then
  echo "Error: CHANNEL_ACCESS_TOKEN environment variable is not set."
  exit 1
fi

# Start the server
echo "Starting LINE Bot MCP Server..."
supergateway --stdio "node /app/dist/index.js" --port 8000 --outputTransport sse
