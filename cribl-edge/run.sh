#!/usr/bin/with-contenv bashio
trap '/opt/cribl/bin/cribl stop; kill `jobs -p`' SIGTERM SIGINT

bashio::log.info "Cribl Edge initializing"
bashio::log.info "Dist-Mode: \"$(bashio::config 'CRIBL_DIST_MODE')\""
export CRIBL_DIST_MODE=$(bashio::config 'CRIBL_DIST_MODE')
export CRIBL_DIST_MASTER_URL=$(bashio::config 'CRIBL_DIST_MASTER_URL')

bashio::log.info "Base URL: \"$(bashio::addon.ingress_entry)\""
CRIBL_YML=${CRIBL_VOLUME_DIR}/local/edge/cribl.yml
if [ -e ${CRIBL_YML} ]; then
  if grep -q baseUrl ${CRIBL_YML}; then
    sed -i "s|^  baseUrl:.*$|  baseUrl: $(bashio::addon.ingress_entry)|" ${CRIBL_YML}
  else
    sed -i "s|^api:|api:\n  baseUrl: $(bashio::addon.ingress_entry)|" ${CRIBL_YML}
  fi
else 
  mkdir -p ${CRIBL_VOLUME_DIR}/local/edge
  echo -e "api:\n  baseUrl: $(bashio::addon.ingress_entry)" > ${CRIBL_YML}
fi

/opt/cribl/bin/cribl start

bashio::log.info "Cribl Edge started"
tail -n 0 -F ${CRIBL_VOLUME_DIR}/log/cribl.log