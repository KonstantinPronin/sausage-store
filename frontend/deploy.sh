set -xe

sudo cp -rf sausage-store-frontend.service /etc/systemd/system/sausage-store-frontend.service < /dev/null
sudo rm -rf /var/www-data/dist/frontend||true < /dev/null

curl -u ${NEXUS_REPO_USER}:${NEXUS_REPO_PASS} -o sausage-store.tar ${ARTIFACTS_URL}
sudo tar -xf sausage-store.tar -C /var/www-data/dist/ < /dev/null

sudo systemctl daemon-reload < /dev/null
sudo systemctl restart sausage-store-backend < /dev/null