#BASE PKG INSTALL STAGE
FROM node:11-alpine AS baseImage
ARG VERSION
RUN set -eux \
&& apk update \
&& apk upgrade \
&& echo @edge http://nl.alpinelinux.org/alpine/edge/community >> /etc/apk/repositories \
&& echo @edge http://nl.alpinelinux.org/alpine/edge/main >> /etc/apk/repositories \
&& apk add --update --update-cache chromium@edge nss@edge \ 
  freetype@edge \
  harfbuzz@edge \
  ca-certificates  \
&& apk del curl g++ gcc linux-headers make python \
&& rm -rf /usr/include /var/cache/apk/* /root/.node-gyp /usr/share/man /tmp/* \
&& mkdir /app && chown node:node /app \
&& echo 
COPY config/etc/ /etc/chromium/
ARG BUILD_DATE
ARG VCS_REF
LABEL     org.label-schema.build-date=$BUILD_DATE \
          org.label-schema.name=nodechrome \
          org.label-schema.description='This will serve as base image for nodejs apps using chromium headless' \
          org.label-schema.vcs-url='https://github.com/c4nc/nodechrome' \
          org.label-schema.vcs-ref=$VCS_REF \
          org.label-schema.version=$VERSION \
          org.label-schema.vendor=C4nC \
          org.label-schema.url='https://who.c4nc.io/' \
          org.label-schema.schema-version=1.0 
ENTRYPOINT [ "/bin/sh", "-c"]