#!/bin/bash

set -e
set -o pipefail

FUNCTIONS_FILE="${SALT_BUILD_DIR}/functions.sh"
source "${FUNCTIONS_FILE}"

salt-minion --version

log_info "Starting minion ..."
salt-minion 
