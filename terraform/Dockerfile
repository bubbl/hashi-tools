FROM alpine:3.5
MAINTAINER Bart Bania <contact@bartbania.com>

ENV TERRA_VERSION=0.9.4
ENV HASHICORP_RELEASES=https://releases.hashicorp.com

RUN apk add --no-cache ca-certificates curl gnupg libcap openssl && \
    gpg --recv-keys 91A6E7F85D05C65630BEF18951852D87348FFC4C && \
    mkdir -p /tmp/build && \
    cd /tmp/build && \
    wget ${HASHICORP_RELEASES}/terraform/${TERRA_VERSION}/terraform_${TERRA_VERSION}_linux_amd64.zip && \
    wget ${HASHICORP_RELEASES}/terraform/${TERRA_VERSION}/terraform_${TERRA_VERSION}_SHA256SUMS && \
    wget ${HASHICORP_RELEASES}/terraform/${TERRA_VERSION}/terraform_${TERRA_VERSION}_SHA256SUMS.sig && \
    gpg --batch --verify terraform_${TERRA_VERSION}_SHA256SUMS.sig terraform_${TERRA_VERSION}_SHA256SUMS && \
    grep terraform_${TERRA_VERSION}_linux_amd64.zip terraform_${TERRA_VERSION}_SHA256SUMS | sha256sum -c && \
    unzip -d /bin terraform_${TERRA_VERSION}_linux_amd64.zip && \
    cd /tmp && \
    rm -rf /tmp/build && \
    apk del gnupg openssl && \
    rm -rf /root/.gnupg

ENTRYPOINT ["/bin/terraform"]
