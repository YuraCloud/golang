# Pterodactyl Golang Custom Egg

This repository contains a custom Pterodactyl Egg for running Golang applications.

## Features
- **Optimized Docker Image**: Based on Alpine Linux for minimal footprint.
- **Auto-dependency Management**: Runs `go mod tidy` if `go.mod` is present.
- **Support for Restart/Stop**: Correctly handles signals for graceful shutdown.

## How to use
1. **Docker Image**:
   - Build and push the Docker image to your GitHub Container Registry:
     ```bash
     docker build -t ghcr.io/yuracloud/golang:latest .
     docker push ghcr.io/yuracloud/golang:latest
     ```
   - Update the `docker_images` section in `golang.json` with your image URL.

2. **Egg Installation**:
   - Go to your Pterodactyl Panel -> Nests -> Import Egg.
   - Select the `egg/golang.json` file.

3. **Server Setup**:
   - Create a new server using the imported Egg.
   - The default startup command is optimized for Go applications.
