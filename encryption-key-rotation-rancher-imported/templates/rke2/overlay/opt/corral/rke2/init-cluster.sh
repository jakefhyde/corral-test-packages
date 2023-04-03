#!/bin/bash
set -ex

CORRAL_api_host="rke2-kube-api.${CORRAL_fqdn}"
echo "corral_set api_host=${CORRAL_api_host}"

mkdir -p /etc/rancher/rke2
cat > /etc/rancher/rke2/config.yaml <<- EOF
tls-san:
  - ${CORRAL_api_host}
EOF

curl -sfL https://get.rke2.io | sh -
systemctl enable rke2-server.service
systemctl start rke2-server.service

sed -i "s/127.0.0.1/${CORRAL_api_host}/g" /etc/rancher/rke2/rke2.yaml

echo "corral_set kubeconfig=$(cat /etc/rancher/rke2/rke2.yaml | base64 -w 0)"
echo "corral_set node_token=$(cat /var/lib/rancher/rke2/server/node-token)"

journalctl -u rke2-server.service --no-pager
