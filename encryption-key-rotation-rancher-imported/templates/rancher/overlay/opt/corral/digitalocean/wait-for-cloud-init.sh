#!/bin/bash
set -ex

echo 'Waiting for cloud init...'
cloud-init status --wait > /dev/null

systemctl restart systemd-journald