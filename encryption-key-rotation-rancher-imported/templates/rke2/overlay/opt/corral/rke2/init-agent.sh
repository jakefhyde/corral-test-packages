#!/bin/bash
set -ex

if [ -f "/etc/rancher/rke2/config.yaml" ]; then
  echo "corral_log /etc/rancher/rke2/config.yaml already found, this must be the init node"
  exit 0
fi

mkdir -p /etc/rancher/rke2
cat > /etc/rancher/rke2/config.yaml <<- EOF
server: https://${CORRAL_kube_api_host}:9345
token: ${CORRAL_node_token}
tls-san:
  - ${CORRAL_kube_api_host}
EOF

curl -sfL https://get.rke2.io | INSTALL_RKE2_TYPE="agent" sh -
systemctl enable rke2-agent.service
systemctl start rke2-agent.service
