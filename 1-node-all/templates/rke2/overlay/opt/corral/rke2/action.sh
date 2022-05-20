#!/bin/sh

currentGeneration=""
key=$1
targetGeneration=$2
runtime=$3
shift
shift
shift

dataRoot="/var/lib/rancher/$runtime/$key"
generationFile="$dataRoot/generation"

currentGeneration=$(cat "$generationFile" || echo "")

if [ "$currentGeneration" != "$targetGeneration" ]; then
  $runtime $@
else
	echo "action has already been reconciled to the current generation."
fi

mkdir -p $dataRoot
echo $targetGeneration > "$generationFile"
