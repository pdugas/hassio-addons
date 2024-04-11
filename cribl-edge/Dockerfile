ARG BUILD_FROM
FROM $BUILD_FROM

RUN apt-get update && apt-get install -y \
    curl jq \
    && rm -rf /var/lib/apt/lists/*

ARG BUILD_ARCH
ARG BUILD_VERSION
RUN curl -Ls https://cdn.cribl.io/dl/$(echo $BUILD_VERSION | sed 's/-.*//')/cribl-${BUILD_VERSION}-linux-$(echo $BUILD_ARCH | sed -e 's/aarch64/arm64/i' -e 's/amd64/x64/i').tgz | tar -C /opt -zxf -

COPY run.sh /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]

ARG BUILD_DATE
ARG BUILD_DESCRIPTION
ARG BUILD_NAME
ARG BUILD_REF
ARG BUILD_REPOSITORY
LABEL \
  io.hass.name="${BUILD_NAME}" \
  io.hass.description="${BUILD_DESCRIPTION}" \
  io.hass.arch="${BUILD_ARCH}" \
  io.hass.type="addon" \
  io.hass.version=${BUILD_VERSION} \
  maintainer="Paul Dugas <paul@dugas.cc>" \
  org.opencontainers.image.title="${BUILD_NAME}" \
  org.opencontainers.image.description="${BUILD_DESCRIPTION}" \
  org.opencontainers.image.vendor="Cribl, Inc." \
  org.opencontainers.image.authors="Paul Dugas <paul@dugas.cc>" \
  org.opencontainers.image.url="https://github.com/${BUILD_REPOSITORY}/" \
  org.opencontainers.image.source="https://github.com/${BUILD_REPOSITORY}/" \
  org.opencontainers.image.documentation="https://github.com/${BUILD_REPOSITORY}/blob/main/README.md" \
  org.opencontainers.image.created=${BUILD_DATE} \
  org.opencontainers.image.revision=${BUILD_REF} \
  org.opencontainers.image.version=${BUILD_VERSION}
