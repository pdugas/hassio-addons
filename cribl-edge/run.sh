#!/usr/bin/with-contenv bashio
trap '/opt/cribl/bin/cribl stop; kill `jobs -p`' SIGTERM SIGINT

bashio::log.info "Cribl Edge initializing"
bashio::log.info "Dist-Mode: \"$(bashio::config 'CRIBL_DIST_MODE')\""
export CRIBL_DIST_MODE=$(bashio::config 'CRIBL_DIST_MODE')
export CRIBL_DIST_MASTER_URL=$(bashio::config 'CRIBL_DIST_MASTER_URL')

INGRESS_ENTRY="$(bashio::addon.ingress_entry)"
bashio::log.info "Base URL: \"${INGRESS_ENTRY}\""
CRIBL_YML=${CRIBL_VOLUME_DIR}/local/edge/cribl.yml
if [ -e ${CRIBL_YML} ]; then
  if grep -q baseUrl ${CRIBL_YML}; then
    sed -i "s|^  baseUrl:.*$|  baseUrl: ${INGRESS_ENTRY}|" ${CRIBL_YML}
  else
    sed -i "s|^api:|api:\n  baseUrl: ${INGRESS_ENTRY}|" ${CRIBL_YML}
  fi
  if ! grep -q proxyStripsPath ${CRIBL_YML}; then
    sed -i "/^  baseUrl:/a\  proxyStripsPath: true" ${CRIBL_YML}
  else
    sed -i "s|^  proxyStripsPath:.*$|  proxyStripsPath: true|" ${CRIBL_YML}
  fi
else
  mkdir -p ${CRIBL_VOLUME_DIR}/local/edge
  echo -e "api:\n  baseUrl: ${INGRESS_ENTRY}\n  proxyStripsPath: true\n  host: 0.0.0.0\n  port: 9420" > ${CRIBL_YML}
fi

/opt/cribl/bin/cribl start

bashio::log.info "Cribl Edge started"
tail -n 0 -F ${CRIBL_VOLUME_DIR}/log/cribl.log