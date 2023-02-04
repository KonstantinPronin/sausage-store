#!/bin/bash
set +e
cat > .env <<EOF
EOF

docker login -u $CI_REGISTRY_USER -p $CI_REGISTRY_PASSWORD $CI_REGISTRY
docker network create -d bridge sausage_network || true
docker pull ${CI_REGISTRY_IMAGE}/sausage-frontend:${VERSION}
docker stop frontend || true
docker rm frontend || true
set -e

docker run -d --name frontend \
    --network=sausage_network \
    --restart always \
    --pull always \
    --env-file .env \
    -p 80:80 \
    ${CI_REGISTRY_IMAGE}/sausage-frontend:${VERSION}