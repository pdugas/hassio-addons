#!/usr/bin/with-contenv bashio
trap '/opt/cribl/bin/cribl stop; kill `jobs -p`' SIGTERM SIGINT

bashio::log.info "Cribl Edge initializing"
bashio::log.info "Dist-Mode: \"$(bashio::config 'CRIBL_DIST_MODE')\""
export CRIBL_DIST_MODE=$(bashio::config 'CRIBL_DIST_MODE')
export CRIBL_DIST_MASTER_URL=$(bashio::config 'CRIBL_DIST_MASTER_URL')
export CRIBL_API_HOST=0.0.0.0

bashio::log.info "Base URL: \"$(bashio::addon.ingress_entry)\""
sed -i -e "s|^api:|api:\n  baseUrl: $(bashio::addon.ingress_entry)|" ${CRIBL_VOLUME_DIR}/local/edge/cribl.yml

/opt/cribl/bin/cribl start

bashio::log.info "Cribl Edge started"
tail -n 0 -F ${CRIBL_VOLUME_DIR}/log/cribl.log