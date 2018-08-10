#!/bin/bash

set -eu

usage () { 
cat << EOF
Stops a release pods.

Usage: 
   helm stop [REPLICA_VALUE_NAME] [RELEASE_NAME] [CHART_PATH]

EOF
}

while [[ $# -gt 0 ]]
do
   key="$1"

   case $key in
      -h|--help)
         usage
         exit 0
         ;;
      *)
         positional+=("$1")
         shift
         ;;
   esac
done
set -- "${positional[@]}" # restore positional parameters

if [ $# -lt 3 ]; then
    usage
    echo "Error: Command line argument missing."
    exit 1
fi
if [ $# -gt 3 ]; then
    usage
    echo "Error: Unrecognized command line argument."
    exit 1
fi

value=$1
release=$2
chart=$3

$HELM_BIN upgrade --set ${value}=0 ${release} ${chart}
