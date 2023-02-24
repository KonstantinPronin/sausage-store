#!/bin/bash
set +e
cat > .env <<EOF
VAULT_TOKEN=${VAULT_TOKEN}
PSQL_CONNECTION_STRING=${PSQL_CONNECTION_STRING}
PSQL_USER=${PSQL_USER}
PSQL_PASSWORD=${PSQL_PASSWORD}
MONGO_CONNECTION_STRING=${MONGO_CONNECTION_STRING}
DB=${MONGO_CONNECTION_STRING}&tlsCaFile=YandexInternalRootCA.crt
LOG_PATH=/logs/
REPORT_PATH=/var/www-data/htdocs
EOF

docker login -u $CI_REGISTRY_USER -p $CI_REGISTRY_PASSWORD $CI_REGISTRY
# docker network create -d bridge sausage_network || true
# docker pull ${CI_REGISTRY_IMAGE}/sausage-frontend:${VERSION}
# docker stop frontend || true
# docker rm frontend || true
set -e

docker-compose up -d frontend