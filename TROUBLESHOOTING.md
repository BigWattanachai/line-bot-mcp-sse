# Troubleshooting Guide for LINE Bot MCP Server

This guide provides solutions to common issues you might encounter when setting up and running the LINE Bot MCP Server.

## Environment Variable Issues

### Problem: "Please set CHANNEL_ACCESS_TOKEN" error

**Solution:**
1. Make sure you've set the environment variable correctly:
   ```bash
   export CHANNEL_ACCESS_TOKEN="your_token_here"
   ```
2. Verify the token is valid and not expired
3. If using Docker, ensure the environment variable is passed to the container

### Problem: Messages not being sent to the user

**Solution:**
1. Check if `DESTINATION_USER_ID` is set correctly
2. Verify that the user has added your LINE Official Account as a friend
3. Check if your Channel Access Token has the necessary permissions

## Server Connection Issues

### Problem: Server fails to start

**Solution:**
1. Check if port 8000 is already in use:
   ```bash
   lsof -i :8000
   ```
2. Verify Node.js version is 20 or later:
   ```bash
   node --version
   ```
3. Check for any error messages in the console output

### Problem: Supergateway not found

**Solution:**
1. Install supergateway globally:
   ```bash
   npm install -g supergateway
   ```
2. Check if the installation path is in your PATH environment variable

## Docker Issues

### Problem: Docker container exits immediately

**Solution:**
1. Check the container logs:
   ```bash
   docker logs <container_id>
   ```
2. Ensure environment variables are passed correctly
3. Verify the Dockerfile has the correct ENTRYPOINT

### Problem: Cannot connect to the server running in Docker

**Solution:**
1. Make sure port 8000 is exposed and mapped correctly
2. Check if Docker network settings are configured properly
3. Verify the container is running:
   ```bash
   docker ps
   ```

## LINE API Issues

### Problem: "Invalid access token" error

**Solution:**
1. Generate a new Channel Access Token from the LINE Developer Console
2. Update your environment variable with the new token
3. Restart the server

### Problem: Cannot send messages to users

**Solution:**
1. Verify your LINE Official Account has the Messaging API enabled
2. Check if the user has added your LINE Official Account as a friend
3. Ensure your account has not reached the message quota limit

## Debugging Tips

1. Add more logging to the code to identify where issues occur
2. Run the server with verbose output:
   ```bash
   DEBUG=* ./run.sh
   ```
3. Check the LINE Developers Console for any API errors or logs
4. Verify network connectivity to LINE's API servers

## Getting Help

If you're still experiencing issues:
1. Check the [LINE Messaging API documentation](https://developers.line.biz/en/docs/messaging-api/)
2. Open an issue on the GitHub repository
3. Contact LINE Developer Support
