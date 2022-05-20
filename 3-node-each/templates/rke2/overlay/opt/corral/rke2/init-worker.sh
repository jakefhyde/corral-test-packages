#!/bin/bash
set -ex

mkdir -p /etc/rancher/rke2
cat > /etc/rancher/rke2/config.yaml <<- EOF
server: https://${CORRAL_api_host}:9345
token: ${CORRAL_node_token}
tls-san:
  - ${CORRAL_api_host}
EOF

curl -sfL https://get.rke2.io | INSTALL_RKE2_TYPE="agent" sh -
systemctl enable rke2-agent.service
systemctl start rke2-agent.service

journalctl -u rke2-server.service --no-pager
