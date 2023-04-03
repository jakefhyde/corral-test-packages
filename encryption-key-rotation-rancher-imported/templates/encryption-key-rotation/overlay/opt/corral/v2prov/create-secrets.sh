#!/bin/bash

if ! command -v kubectl &> /dev/null; then
  echo "corral_log Installing kubectl"
  curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
  sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
fi

export KUBECONFIG=/etc/rancher/rke2/rke2.yaml
kubectl create namespace test-encryption-key-rotation && for i in {1..10000}; do kubectl create secret generic test$i -n test-encryption-key-rotation --from-literal=key$1=value$i; done
