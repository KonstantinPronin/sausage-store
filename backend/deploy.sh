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
set -e

if docker ps | grep -q backend-blue; then
    docker compose stop backend-green
    docker compose up --wait backend-green
    docker compose stop backend-blue
else    
    docker compose stop backend-blue
    docker compose up --wait backend-blue
    docker compose stop backend-green
fi
