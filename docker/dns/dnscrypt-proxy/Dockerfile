# syntax=docker/dockerfile:1

FROM --platform=${BUILDPLATFORM} golang:1.19-alpine as builder

RUN apk add build-base

WORKDIR /src

ARG DNSCRYPT_PROXY_VERSION=2.1.2

ADD https://github.com/DNSCrypt/dnscrypt-proxy/archive/${DNSCRYPT_PROXY_VERSION}.tar.gz /tmp/dnscrypt-proxy.tar.gz

RUN tar xzf /tmp/dnscrypt-proxy.tar.gz --strip 1

WORKDIR /src/dnscrypt-proxy

RUN CGO_ENABLED=0 go build -v -ldflags="-s -w" -mod vendor

WORKDIR /config

RUN cp -a /src/dnscrypt-proxy/example-* ./

FROM --platform=${BUILDPLATFORM} alpine:latest as runner

COPY --from=builder /src/dnscrypt-proxy/dnscrypt-proxy /bin
COPY --from=builder /config /config
COPY dnscrypt-proxy.toml /config/

RUN chown nobody /config

USER nobody

ENTRYPOINT [ "/bin/dnscrypt-proxy" ]

CMD [ "-config", "/config/dnscrypt-proxy.toml" ]
