FROM golang:1.22-alpine

RUN apk add --no-cache --update \
    curl \
    ca-certificates \
    git \
    tzdata \
    iproute2 \
    bash \
    build-base

# Create a user for the container
RUN adduser -D -h /home/container container

USER container
ENV USER=container HOME=/home/container
WORKDIR /home/container

COPY ./entrypoint.sh /entrypoint.sh
CMD ["/bin/bash", "/entrypoint.sh"]
