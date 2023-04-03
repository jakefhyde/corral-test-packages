#!/bin/bash

runtimeServer=$1
i=0

while [ $i -lt 10 ]; do
		systemctl is-active $runtimeServer
		if [ $? -eq 0 ]; then
				exit 0
		fi
		sleep 10
		i=$((i + 1))
done
exit 1
