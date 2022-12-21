set -xe

sudo cp -rf sausage-store-backend.service /etc/systemd/system/sausage-store-backend.service < /dev/null
sudo rm -f /var/jarservice/sausage-store.jar||true < /dev/null

curl -u ${NEXUS_REPO_USER}:${NEXUS_REPO_PASS} -o sausage-store.jar ${ARTIFACTS_URL}
sudo cp ./sausage-store.jar /var/jarservice/sausage-store.jar||true < /dev/null
sudo chown jarservice /var/jarservice/sausage-store.jar < /dev/null
sudo chmod u+x /var/jarservice/sausage-store.jar < /dev/null

sudo systemctl daemon-reload < /dev/null
sudo systemctl restart sausage-store-backend < /dev/null