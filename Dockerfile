FROM        --platform=$TARGETOS/$TARGETARCH golang:1.23-alpine AS builder

RUN         apk add --update --no-cache git build-base
RUN         go install golang.org/x/vuln/cmd/govulncheck@latest

FROM        --platform=$TARGETOS/$TARGETARCH golang:1.23-alpine

RUN         apk add --update --no-cache ca-certificates tzdata git bash \
            && adduser -D -h /home/container container

COPY        --from=builder /go/bin/govulncheck /usr/local/bin/govulncheck

USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container

COPY        ./entrypoint.sh /entrypoint.sh
CMD         [ "/bin/ash", "/entrypoint.sh" ]
