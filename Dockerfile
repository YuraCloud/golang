FROM        --platform=$TARGETOS/$TARGETARCH golang:1.23-alpine

RUN         apk add --update --no-cache ca-certificates tzdata git build-base \
            && adduser -D -h /home/container container

# Install govulncheck for security scanning
RUN         go install golang.org/x/vuln/cmd/govulncheck@latest

USER        container
ENV         USER=container HOME=/home/container PATH=$PATH:/home/container/go/bin
WORKDIR     /home/container

COPY        ./entrypoint.sh /entrypoint.sh
CMD         [ "/bin/ash", "/entrypoint.sh" ]
