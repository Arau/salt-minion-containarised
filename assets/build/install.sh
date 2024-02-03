#!/usr/bin/env bash

set -o errexit
set -o pipefail

export DEBIAN_FRONTEND=noninteractive
source "${SALT_BUILD_DIR}/functions.sh"

log_info "Adding salt repository..."
add_salt_repository
apt-get update

log_info "Installing salt packages ..."
install_pkgs salt-minion="${SALT_VERSION}"

log_info "Installing python packages ..."
salt-pip install pygit2==1.14.0

# cleanup apt
apt-get clean --yes
rm -rf /var/lib/apt/lists/*

export -n DEBIAN_FRONTEND
