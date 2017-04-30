FROM alpine:3.5
MAINTAINER Bart Bania <contact@bartbania.com>

ENV VAULT_VERSION=0.7.0
ENV DOCKER_BASE=https://p.onetwentyseven001.com:8443/
ENV HASHICORP_RELEASES=https://releases.hashicorp.com

RUN addgroup vault && \
    adduser -S -G vault vault

RUN apk add --no-cache ca-certificates curl gnupg libcap openssl && \
    gpg --recv-keys D48F2669 && \
    gpg --recv-keys 91A6E7F85D05C65630BEF18951852D87348FFC4C && \
    mkdir -p /tmp/build && \
    cd /tmp/build && \
    wget ${DOCKER_BASE}/docker_base/docker-base.zip && \
    wget ${DOCKER_BASE}/docker_base/docker-base_SHA256SUMS && \
    wget ${DOCKER_BASE}/docker_base/docker-base_SHA256SUMS.sig && \
    gpg --batch --verify docker-base_SHA256SUMS.sig docker-base_SHA256SUMS && \
    grep docker-base.zip docker-base_SHA256SUMS | sha256sum -c && \
    unzip docker-base.zip && \
    cp bin/gosu bin/dumb-init /bin && \
    wget ${HASHICORP_RELEASES}/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_linux_amd64.zip && \
    wget ${HASHICORP_RELEASES}/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_SHA256SUMS && \
    wget ${HASHICORP_RELEASES}/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_SHA256SUMS.sig && \
    gpg --batch --verify vault_${VAULT_VERSION}_SHA256SUMS.sig vault_${VAULT_VERSION}_SHA256SUMS && \
    grep vault_${VAULT_VERSION}_linux_amd64.zip vault_${VAULT_VERSION}_SHA256SUMS | sha256sum -c && \
    unzip -d /bin vault_${VAULT_VERSION}_linux_amd64.zip && \
    cd /tmp && \
    rm -rf /tmp/build && \
    apk del gnupg openssl && \
    rm -rf /root/.gnupg

RUN mkdir -p /vault/logs && \
    mkdir -p /vault/file && \
    mkdir -p /vault/config && \
    chown -R vault:vault /vault

VOLUME /vault/logs
VOLUME /vault/file

COPY ./config/config.hcl /vault/config/config.hcl
COPY ./config/entrypoint.sh /usr/local/bin/entrypoint.sh

EXPOSE 8200

ENTRYPOINT [ "entrypoint.sh" ]
