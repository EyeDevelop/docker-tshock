FROM alpine

RUN apk add -U bash curl unzip shadow su-exec
RUN apk add -U -X http://dl-cdn.alpinelinux.org/alpine/edge/testing mono

COPY entrypoint.sh /
COPY server_config.cfg /server_config.cfg

ENV PUID 1000
ENV PGID 1000
CMD ["/entrypoint.sh"]