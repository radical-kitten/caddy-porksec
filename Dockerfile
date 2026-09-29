FROM dhi.io/golang:1-dev AS builder

RUN CGO_ENABLED=0 go install github.com/caddyserver/xcaddy/cmd/xcaddy@latest

WORKDIR /build
RUN xcaddy build \
    --with github.com/caddy-dns/porkbun
    --with github.com/hslatman/caddy-crowdsec-bouncer/crowdsec

FROM dhi.io/caddy:2
COPY --from=builder /build/caddy /usr/local/bin/caddy
