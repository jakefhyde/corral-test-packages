#!/bin/bash

runtime=$1
runtimeServer=$2
phase=$3
expectedPhase=$4

/opt/corral/rke2/action.sh rancher_v2prov_encryption_key_rotation/$phase 1 $runtime secrets-encrypt $phase
if [ $? -ne 0 ]; then
    exit 0
fi

/opt/corral/rke2/wait_for_secrets_encrypt_status.sh $expectedPhase $runtime $runtimeServer
if [ $? -ne 0 ]; then
    exit 0
fi

/opt/corral/rke2/wait_for_systemctl_status.sh $runtimeServer
if [ $? -ne 0 ]; then
    exit 0
fi

systemctl restart $runtimeServer
if [ $? -ne 0 ]; then
    exit 0
fi

/opt/corral/rke2/wait_for_systemctl_status.sh $runtimeServer
if [ $? -ne 0 ]; then
    exit 0
fi

exit 0
