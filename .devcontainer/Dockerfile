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
    # Download and verify sha256 dockerize
    && FILE="dockerize.tar.gz" \
    && SHAFILE="dockerize.tar.gz.sha256" \
    && curl -L -o ${FILE} ${DOCKERIZE_URL} \
    && if [ -f "${SHAFILE}" ]; then echo "${SHAFILE}"; fi \
    && echo "${DOCKERIZE_CHECKSUM}  ${FILE}" > "${SHAFILE}" \
    && sha256sum -c "${SHAFILE}" \
    && tar -xzf ${FILE} -C /usr/local/bin \
    && rm ${FILE} ${SHAFILE} \
    # Download and verify sha256 tfprovidercheck
    && FILE="tfprovidercheck.tar.gz" \
    && SHAFILE="tfprovidercheck.tar.gz.sha256" \
    && curl -L -o ${FILE} ${TFPROVIDERCHECK_URL} \
    && if [ -f "${SHAFILE}" ]; then rm "${SHAFILE}"; fi \
    && echo "${TFPROVIDERCHECK_CHECKSUM}  ${FILE}" > "${SHAFILE}" \
    && sha256sum -c "${SHAFILE}" \
    && tar -xzf ${FILE} -C /usr/local/bin \
    && rm ${FILE} ${SHAFILE} \
    # Download and verify sha256 bats-core
    && FILE="bats-core.tar.gz" \
    && SHAFILE="${FILE}.sha256" \
    && curl -L -o ${FILE} ${BATS_URL} \
    && if [ -f "${SHAFILE}" ]; then rm "${SHAFILE}"; fi \
    && echo "${BATS_CHECKSUM}  ${FILE}" > "${SHAFILE}" \
    && sha256sum -c "${SHAFILE}" \
    && tar -xzf ${FILE} -C /tmp \
    && ./tmp/bats-core-*/install.sh /usr/local \
    && rm ${FILE} ${SHAFILE}

USER vscode

HEALTHCHECK NONE
