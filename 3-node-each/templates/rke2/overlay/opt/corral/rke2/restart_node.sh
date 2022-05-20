#!/bin/sh

runtimeServer=$1

systemctl restart $runtimeServer

/opt/corral/rke2/wait_for_systemctl_status.sh $runtimeServer
