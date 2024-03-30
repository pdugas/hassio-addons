#!/usr/bin/with-contenv bashio
trap '/opt/cribl/bin/cribl stop; kill `jobs -p`' SIGTERM SIGINT
[ -e /opt/cribl/local/_system/instance.yml ] || /opt/cribl/bin/cribl mode-edge -H 0.0.0.0
/opt/cribl/bin/cribl start
tail -n 0 -F /opt/cribl/log/cribl.log
