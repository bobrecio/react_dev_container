# Devbox React Container

A containerized development environment for Vite-based React apps using Docker Compose.

## Features

- Vite-only dev setup (no port 3000)
- Dynamically create new React or React+TypeScript apps
- Auto-detects if a new app needs to be initialized
- Opens browser to localhost:5173 automatically
- Select and switch between multiple apps with a simple script

## Getting Started

1. Clone this repo
2. Make scripts executable:

    ```bash
    chmod +x select-app.sh switch-app.sh
    ```

3. Run the selection script:

    ```bash
    ./select-app.sh
    ```

4. Create or select an app and get developing 🚀

## Folder Structure

- `devbox/` — Contains your Vite apps
- `Dockerfile` — Builds the container
- `docker-compose.yml` — Defines the dev environment
- `select-app.sh` — Menu to create/select apps
- `switch-app.sh` — Switches between apps and rebuilds the container
