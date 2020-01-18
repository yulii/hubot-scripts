FROM alpine:latest

RUN apk update && apk add --no-cache \
    npm yarn

WORKDIR /app
