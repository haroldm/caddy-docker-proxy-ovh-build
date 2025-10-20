FROM caddy:2.10.2-builder AS builder

ARG CADDY_DOCKER_PROXY_VERSION=2.10.0
ARG CADDY_DNS_OVH_VERSION=1.1.0
RUN xcaddy build \
    # --with github.com/lucaslorentz/caddy-docker-proxy@v$CADDY_DOCKER_PROXY_VERSION \
    # Temporary: build with unreleased https://github.com/lucaslorentz/caddy-docker-proxy/pull/743
    --with github.com/lucaslorentz/caddy-docker-proxy/v2@7d2580108fb99d5025eee14e3adb8e11630fb1f1 \
    --with github.com/caddy-dns/ovh@v$CADDY_DNS_OVH_VERSION

FROM caddy:2.10.2-alpine

COPY --from=builder /usr/bin/caddy /usr/bin/caddy

CMD ["caddy", "docker-proxy"]
