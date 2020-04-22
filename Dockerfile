FROM alpine:latest

RUN apk add --no-cache hugo bash
RUN apk add --no-cache git
RUN apk add --no-cache npm

RUN npm install -g postcss-cli
RUN npm install -g autoprefixer

ADD entrypoint.sh /
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
