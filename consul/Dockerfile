FROM alpine:3.5
MAINTAINER Bart Bania <contact@bartbania.com>

ENV CONSUL_VERSION=0.8.1
ENV DOCKER_BASE=https://p.onetwentyseven001.com:8443/
ENV HASHICORP_RELEASES=https://releases.hashicorp.com

RUN addgroup consul && \
    adduser -S -G consul consul

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
    wget ${HASHICORP_RELEASES}/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_linux_amd64.zip && \
    wget ${HASHICORP_RELEASES}/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_SHA256SUMS && \
    wget ${HASHICORP_RELEASES}/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_SHA256SUMS.sig && \
    gpg --batch --verify consul_${CONSUL_VERSION}_SHA256SUMS.sig consul_${CONSUL_VERSION}_SHA256SUMS && \
    grep consul_${CONSUL_VERSION}_linux_amd64.zip consul_${CONSUL_VERSION}_SHA256SUMS | sha256sum -c && \
    unzip -d /bin consul_${CONSUL_VERSION}_linux_amd64.zip && \
    cd /tmp && \
    rm -rf /tmp/build && \
    apk del gnupg openssl && \
    rm -rf /root/.gnupg

RUN mkdir -p /consul/data && \
    mkdir -p /consul/config && \
    chown -R consul:consul /consul

COPY ./config/consul.conf /consul/config/consul.conf
COPY ./config/entrypoint.sh /usr/local/bin/entrypoint.sh

VOLUME /consul/data

EXPOSE 8300
EXPOSE 8301 8301/udp 8302 8302/udp
EXPOSE 8400 8500 8600 8600/udp

ENTRYPOINT [ "entrypoint.sh" ]
