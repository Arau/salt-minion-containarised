#!/bin/bash

set -e
set -o pipefail

FUNCTIONS_FILE="${SALT_BUILD_DIR}/functions.sh"
source "${FUNCTIONS_FILE}"

function usage()
{
    >&2 cat << EOF
Usage: $0
   [ -m | --minion-id input ]
EOF
    exit 1
}

args=$(getopt -o m: --long minion-id: -- "$@")
if [[ $? -gt 0 ]]; then
  usage
fi

eval set -- ${args}
while :
do
  case $1 in
    -m | --minion-id) minion_id=$2; shift 2 ;;
    --) shift; break ;;
    *) >&2 echo Unsupported option: $1
       usage ;;
  esac
done

if [ ! -z $minion_id ]; then
    set_minion_id "$minion_id"
fi

salt-minion --version

log_info "Starting minion ..."
salt-minion 
