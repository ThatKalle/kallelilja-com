FROM mcr.microsoft.com/devcontainers/base:bookworm

ARG DOCKERIZE_VERSION
ARG DOCKERIZE_CHECKSUM
ENV DOCKERIZE_URL="https://github.com/jwilder/dockerize/releases/download/${DOCKERIZE_VERSION}/dockerize-linux-amd64-${DOCKERIZE_VERSION}.tar.gz"
ARG TFPROVIDERCHECK_VERSION
ARG TFPROVIDERCHECK_CHECKSUM
ENV TFPROVIDERCHECK_URL="https://github.com/suzuki-shunsuke/tfprovidercheck/releases/download/${TFPROVIDERCHECK_VERSION}/tfprovidercheck_linux_amd64.tar.gz"
ENV HUGO_PARAMS_gitCommit="d3m0sh4"

USER root

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends \
    ca-certificates \
    coreutils \
    curl \
    git \
    gnupg2 \
    gpg  \
    wget \
    zip \
    && apt-get clean && rm -rf /var/lib/apt/lists/* \
    # Download and verify sha256 dockerize
    && curl -L -o dockerize.tar.gz ${DOCKERIZE_URL} \
    && echo "${DOCKERIZE_CHECKSUM}  dockerize.tar.gz" > dockerize.tar.gz.sha256 \
    && sha256sum -c dockerize.tar.gz.sha256 \
    && tar -xzf dockerize.tar.gz -C /usr/local/bin \
    && rm dockerize.tar.gz dockerize.tar.gz.sha256 \
    # Download and verify sha256 tfprovidercheck
    && curl -L -o tfprovidercheck.tar.gz ${TFPROVIDERCHECK_URL} \
    && echo "${TFPROVIDERCHECK_CHECKSUM}  tfprovidercheck.tar.gz" > tfprovidercheck.tar.gz.sha256 \
    && sha256sum -c tfprovidercheck.tar.gz.sha256 \
    && tar -xzf tfprovidercheck.tar.gz -C /usr/local/bin \
    && rm tfprovidercheck.tar.gz tfprovidercheck.tar.gz.sha256

USER vscode

HEALTHCHECK NONE
