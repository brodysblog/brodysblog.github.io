FROM alpine:latest

RUN apk add --no-cache hugo bash
RUN apk add --no-cache git

ADD entrypoint.sh /
RUN chmod +x /entrypoint.sh
RUN npm install -g postcss-cli

ENTRYPOINT ["/entrypoint.sh"]
