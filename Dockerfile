FROM caddy:2.10.1-builder AS builder

RUN xcaddy build \
    --with github.com/lucaslorentz/caddy-docker-proxy/v2.9.2 \
    --with github.com/caddy-dns/ovh

FROM caddy:2.10.1-alpine

COPY --from=builder /usr/bin/caddy /usr/bin/caddy

CMD ["caddy", "docker-proxy"]
