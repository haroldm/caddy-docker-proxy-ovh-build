FROM caddy:2.10.1-builder AS builder

ARG CADDY_DOCKER_PROXY_VERSION=2.10.0
ARG CADDY_DNS_OVH_VERSION=1.0.1
RUN xcaddy build \
    --with github.com/lucaslorentz/caddy-docker-proxy/v${CADDY_DOCKER_PROXY_VERSION} \
    --with github.com/caddy-dns/ovh/v{CADDY_DNS_OVH_VERSION}

FROM caddy:2.10.1-alpine

COPY --from=builder /usr/bin/caddy /usr/bin/caddy

CMD ["caddy", "docker-proxy"]
