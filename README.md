[日本語版 READMEはこちら](README.ja.md)

# LINE Bot MCP Server SSE

**Original repository:** https://github.com/line/line-bot-mcp-server

[Model Context Protocol (MCP)](https://github.com/modelcontextprotocol) server implementation that integrates the LINE Messaging API to connect an AI Agent to the LINE Official Account.

![](/assets/demo.png)

> [!NOTE]
> This repository is provided as a preview version. While we offer it for experimental purposes, please be aware that it may not include complete functionality or comprehensive support.

## Tools

1. **push_text_message**
  - Push a simple text message to a user via LINE.
  - **Inputs:**
    - `user_id` (string?): The user ID to receive a message. Defaults to DESTINATION_USER_ID.
    - `message.text` (string): The plain text content to send to the user.
2. **push_flex_message**
  - Push a highly customizable flex message to a user via LINE.
  - **Inputs:**
    - `user_id` (string?): The user ID to receive a message. Defaults to DESTINATION_USER_ID.
    - `message.altText` (string): Alternative text shown when flex message cannot be displayed.
    - `message.content` (any): The content of the flex message. This is a JSON object that defines the layout and components of the message.
    - `message.contents.type` (enum): Type of the container. 'bubble' for single container, 'carousel' for multiple swipeable bubbles.
3. **broadcast_text_message**
  - Broadcast a simple text message via LINE to all users who have followed your LINE Official Account.
  - **Inputs:**
    - `message.text` (string): The plain text content to send to the users.
4. **broadcast_flex_message**
  - Broadcast a highly customizable flex message to a user via LINE to all users who have added your LINE Official Account.
  - **Inputs:**
    - `message.altText` (string): Alternative text shown when flex message cannot be displayed.
    - `message.content` (any): The content of the flex message. This is a JSON object that defines the layout and components of the message.
    - `message.contents.type` (enum): Type of the container. 'bubble' for single container, 'carousel' for multiple swipeable bubbles.
5. **reply_text_message**
  - Reply to a specific message with a simple text message via LINE.
  - **Inputs:**
    - `replyToken` (string): The reply token received from a webhook event.
    - `message.text` (string): The plain text content to send to the user.
6. **reply_flex_message**
  - Reply to a specific message with a highly customizable flex message to LINE.
  - **Inputs:**
    - `replyToken` (string): The reply token received from a webhook event.
    - `message.altText` (string): Alternative text shown when flex message cannot be displayed.
    - `message.content` (any): The content of the flex message. This is a JSON object that defines the layout and components of the message.
    - `message.contents.type` (enum): Type of the container. 'bubble' for single container, 'carousel' for multiple swipeable bubbles.
7. **get_profile**
  - Get detailed profile information of a LINE user including display name, profile picture URL, status message and language.
  - **Inputs:**
    - `user_id` (string?): The ID of the user whose profile you want to retrieve. Defaults to DESTINATION_USER_ID.


## Installation

### Step 1: Install line-bot-mcp-server

requirements:
- Node.js v20 or later

Clone this repository:

```
git clone git@github.com:line/line-bot-mcp-server.git
```

Install the necessary dependencies and build line-bot-mcp-server when using Node.js. This step is not required when using Docker:

```
cd line-bot-mcp-server && npm install && npm run build
```

### Step 2: Create LINE Official Account

This MCP server utilizes a LINE Official Account. If you do not have one, please create it by following [this instructions](https://developers.line.biz/en/docs/messaging-api/getting-started/#create-oa).

If you have a LINE Official Account, enable the Messaging API for your LINE Official Account by following [this instructions](https://developers.line.biz/en/docs/messaging-api/getting-started/#using-oa-manager).

### Step 3: Configure AI Agent

Please add the following configuration for an AI Agent like Claude Desktop or Cline.

Set the environment variables or arguments as follows:
- `mcpServers.args`: (required) The path to `line-bot-mcp-server`.
- `CHANNEL_ACCESS_TOKEN`: (required) Channel Access Token. You can confirm this by following [this instructions](https://developers.line.biz/en/docs/basics/channel-access-token/#long-lived-channel-access-token).
- `DESTINATION_USER_ID`: (optional) The default user ID of the recipient. You can confirm this by following [this instructions](https://developers.line.biz/en/docs/messaging-api/getting-user-ids/#get-own-user-id).

#### Option 1: Use Node

```json
{
  "mcpServers": {
    "line-bot": {
      "command": "node",
      "args": [
        "PATH/TO/line-bot-mcp-server/dist/index.js"
      ],
      "env": {
        "CHANNEL_ACCESS_TOKEN" : "FILL_HERE",
        "DESTINATION_USER_ID" : "FILL_HERE"
      }
    }
  }
}
```

#### Option 2: Use Docker

Build the Docker image first:
```
docker build -t line/line-bot-mcp-server .
```

```json
{
  "mcpServers": {
    "line-bot": {
      "command": "docker",
      "args": [
        "run",
        "-i",
        "--rm",
        "-e",
        "CHANNEL_ACCESS_TOKEN",
        "-e",
        "DESTINATION_USER_ID",
        "line/line-bot-mcp-server"
      ],
      "env": {
        "CHANNEL_ACCESS_TOKEN" : "FILL_HERE",
        "DESTINATION_USER_ID" : "FILL_HERE"
      }
    }
  }
}
```

## Deployment

For detailed deployment instructions, see [DEPLOYMENT.md](DEPLOYMENT.md).

### Quick Start

1. Clone the repository
2. Install dependencies: `npm install`
3. Build the project: `npm run build`
4. Run the server:

```bash
export CHANNEL_ACCESS_TOKEN="your_channel_access_token"
export DESTINATION_USER_ID="your_user_id"

./run.sh
```

### Docker Deployment

You can also use Docker to deploy the server:

```bash
# Using docker-compose
docker-compose up -d

# Or using Docker directly with the simple Dockerfile
docker build -t line-bot-mcp-server -f Dockerfile .
docker run -p 8000:8000 \
  -e CHANNEL_ACCESS_TOKEN="your_channel_access_token" \
  -e DESTINATION_USER_ID="your_user_id" \
  line-bot-mcp-server
```

---

## Code of Conduct

This project uses the Contributor Covenant Code of Conduct, version 2.1,  
licensed under CC BY 4.0.  
See https://github.com/EthicalSource/contributor_covenant/blob/release/LICENSE.md

