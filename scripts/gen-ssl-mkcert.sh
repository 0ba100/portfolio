#!/usr/bin/env bash

set -eux

source "$(dirname "$0")/../.env"

mkdir -p "$(dirname "$0")/../caddy/ssl"

cd "$(dirname "$0")/../caddy/ssl"

mkcert -install

mkcert -cert-file cert.pem -key-file key.pem "${KC_HOSTNAME}"
