FROM alpine:latest
RUN apk update && \
    apk upgrade && \
    apk add --no-cache --virtual=build-dependencies ca-certificates
COPY oauth2-proxy /run
RUN addgroup -g 500 oauth-proxy
RUN adduser -G oauth-proxy -D -H -u 500 oauth-proxy
RUN chown -R 500:500 /run/oauth2-proxy
RUN chmod -R 755 /run/oauth2-proxy
USER 500
CMD /run/oauth2-proxy