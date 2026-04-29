FROM        --platform=$TARGETOS/$TARGETARCH golang:1.23-alpine AS builder

RUN         apk add --update --no-cache git build-base
# Manually build govulncheck to bypass go install issues
RUN         git clone --depth 1 https://github.com/golang/vuln.git /vuln \
            && cd /vuln/cmd/govulncheck \
            && CGO_ENABLED=0 go build -ldflags="-s -w" -o /govulncheck .

FROM        --platform=$TARGETOS/$TARGETARCH golang:1.23-alpine

RUN         apk add --update --no-cache ca-certificates tzdata git bash \
            && adduser -D -h /home/container container

COPY        --from=builder /govulncheck /usr/local/bin/govulncheck

USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container

COPY        ./entrypoint.sh /entrypoint.sh
CMD         [ "/bin/ash", "/entrypoint.sh" ]
