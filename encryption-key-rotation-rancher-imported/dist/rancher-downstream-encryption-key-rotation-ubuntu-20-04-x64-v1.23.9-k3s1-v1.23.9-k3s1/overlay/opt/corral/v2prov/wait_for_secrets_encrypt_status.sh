#!/bin/bash

phase=$1
runtime=$2
runtimeServer=$3

i=0

while [ $i -lt 60 ]; do
    output="$($runtime secrets-encrypt status)"
    echo $output | grep -q $phase
    if [ $? -eq 0 ]; then
        exit 0
    fi
	sleep 1
	i=$((i + 1))
done

echo "$runtime secrets-encrypt failed to complete in the expected interval!"
journalctl -u $runtimeServer --no-pager