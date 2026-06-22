# Ingress Fix Plan

## Problem

The Cribl Edge UI fails to load when accessed via Home Assistant Ingress. The Supervisor strips the path prefix when forwarding to the add-on (e.g. `/api/hassio_ingress/TOKEN/static/js/main.js` → `/static/js/main.js`), but Cribl Edge mounts routes under `baseUrl`, so requests fall through to the catch-all and return `index.html` instead of static assets. Result: MIME type errors and a blank UI.

## Solution

Cribl PR adds `api.proxyStripsPath` config option. When `true`, the server mounts routes at root (matching the stripped paths) while still using `baseUrl` for HTML/asset URLs so the browser requests the correct paths.

## Add-on Changes (this PR)

- **run.sh**: Configure `proxyStripsPath: true` in cribl.yml when setting up for Ingress. The script now adds/updates this option alongside `baseUrl` on every add-on start.

## Follow-up (when Cribl merges and releases)

1. Update `config.yml` version to the Cribl Edge release that includes `proxyStripsPath` (check [cribl_version_urls.json](https://cdn.cribl.io/dl/cribl_version_urls.json))
2. Rebuild the add-on image
3. Test Ingress in Home Assistant

## References

- Cribl PR: (add link when available)
- [HA Supervisor ingress.py](https://github.com/home-assistant/supervisor/blob/master/supervisor/api/ingress.py) – path is stripped in `_create_url()`
