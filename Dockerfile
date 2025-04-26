FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y curl gnupg git ca-certificates && \
    curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs npm && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ARG APP_PATH=app-one
ENV APP_PATH=${APP_PATH}

WORKDIR /devbox

COPY devbox/ /devbox/

WORKDIR /devbox/$APP_PATH

CMD ["/bin/bash", "-c", "\
    if [ ! -f package.json ]; then \
      echo 'No package.json found. Creating new Vite app...'; \
      template=$(grep REACT_TEMPLATE .vite-template | cut -d= -f2 2>/dev/null || echo react); \
      npm create vite@latest . -- --template $template && \
      npm install; \
    else \
      echo 'Found existing app. Installing dependencies...'; \
      npm install; \
    fi && \
    npm run dev"]
