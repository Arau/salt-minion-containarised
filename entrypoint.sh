#!/bin/bash

set -e
set -o pipefail

FUNCTIONS_FILE="${SALT_BUILD_DIR}/functions.sh"
source "${FUNCTIONS_FILE}"

function usage()
{
    >&2 cat << EOF
Usage: $0
   [ -a | --salt-master-address input ]
   [ -m | --minion-id input ]
   [ -h ]
EOF
    exit 1
}

args=$(getopt -o a:m:h --long salt-master-address:,minion-id:,help -- "$@")
if [[ $? -gt 0 ]]; then
  usage
fi

eval set -- ${args}
while :
do
  case $1 in
    -m | --minion-id)           minion_id=$2;        shift 2 ;;
    -a | --salt-master-address) salt_master_addr=$2; shift 2 ;;
    -h | --help)                usage              ; shift   ;;
    --) shift; break ;;
    *) >&2 echo Unsupported option: $1
       usage ;;
  esac
done

if [ ! -z $salt_master_addr ]; then
    initialize_minion_conf
    set_salt_master_addr "$salt_master_addr"
else
    log_error "Missing mandatory data: --salt-master-address=address"
    usage
    exit 1
fi

if [ ! -z $minion_id ]; then
    set_minion_id "$minion_id"
fi

salt-minion --version

log_info "Starting minion ..."
salt-minion 
