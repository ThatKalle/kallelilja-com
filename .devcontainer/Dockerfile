FROM mcr.microsoft.com/devcontainers/base:bookworm

ENV DOCKERIZE_VERSION=v0.9.2

ENV HUGO_PARAMS_gitCommit="d3m0sh4"

USER root

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends \
    ca-certificates \
    curl \
    git \
    gnupg2 \
    gpg  \
    wget \
    zip \
    && wget -O - https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz | tar xzf - -C /usr/local/bin \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

USER vscode

HEALTHCHECK NONE
