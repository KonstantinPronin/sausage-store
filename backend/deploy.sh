#!/bin/bash
set +e
cat > .env <<EOF
VAULT_TOKEN=${VAULT_TOKEN}
PSQL_CONNECTION_STRING=${PSQL_CONNECTION_STRING}
PSQL_USER=${PSQL_USER}
PSQL_PASSWORD=${PSQL_PASSWORD}
MONGO_CONNECTION_STRING=${MONGO_CONNECTION_STRING}
LOG_PATH=/logs/
REPORT_PATH=/var/www-data/htdocs
EOF

docker login -u $CI_REGISTRY_USER -p $CI_REGISTRY_PASSWORD $CI_REGISTRY
docker network create -d bridge sausage_network || true
docker pull ${CI_REGISTRY_IMAGE}/sausage-backend:${VERSION}
docker stop backend || true
docker rm backend || true
set -e

docker run -d --name backend \
    --network=sausage_network \
    --restart always \
    --pull always \
    --env-file .env \
    ${CI_REGISTRY_IMAGE}/sausage-backend:${VERSION}