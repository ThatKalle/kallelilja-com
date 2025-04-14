FROM mcr.microsoft.com/devcontainers/base:bookworm

ARG DOCKERIZE_VERSION \
    DOCKERIZE_CHECKSUM \
    TFPROVIDERCHECK_VERSION \
    TFPROVIDERCHECK_CHECKSUM \
    BATS_VERSION \
    BATS_CHECKSUM
ENV DOCKERIZE_URL="https://github.com/jwilder/dockerize/releases/download/${DOCKERIZE_VERSION}/dockerize-linux-amd64-${DOCKERIZE_VERSION}.tar.gz" \
    TFPROVIDERCHECK_URL="https://github.com/suzuki-shunsuke/tfprovidercheck/releases/download/${TFPROVIDERCHECK_VERSION}/tfprovidercheck_linux_amd64.tar.gz" \
    BATS_URL="https://github.com/bats-core/bats-core/archive/refs/tags/${BATS_VERSION}.tar.gz"
ENV HUGO_PARAMS_gitCommit="d3m0sh4"

USER root

COPY dl-verify-extract.sh /usr/local/bin/

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get upgrade -y \
    && apt-get -y install --no-install-recommends \
    ca-certificates \
    coreutils \
    curl \
    git \
    gnupg2 \
    gpg  \
    wget \
    zip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /var/cache/apt/archives/partial/* \
    && chmod +x /usr/local/bin/dl-verify-extract.sh \
    && dl-verify-extract.sh dockerize.tar.gz ${DOCKERIZE_URL} ${DOCKERIZE_CHECKSUM} /usr/local/bin \
    && dl-verify-extract.sh tfprovidercheck.tar.gz ${TFPROVIDERCHECK_URL} ${TFPROVIDERCHECK_CHECKSUM} /usr/local/bin \
    && dl-verify-extract.sh bats-core.tar.gz ${BATS_URL} ${BATS_CHECKSUM} /tmp \
    && ./tmp/bats-core-*/install.sh /usr/local

USER vscode

HEALTHCHECK NONE
