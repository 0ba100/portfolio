#!/usr/bin/env bash

# adopt the .env file
source "$(dirname "$0")/../.env"

set -eux

mkdir -p "$(dirname "$0")/../caddy/ssl"

cd "$(dirname "$0")/../caddy/ssl"

openssl req -x509 -newkey rsa:4096 -keyout key.pem -out cert.pem -sha256 -days 3650 -nodes -subj "/C=XX/ST=XX/L=XX/O=XX/OU=XX/CN=${KC_HOSTNAME}"

echo "SSL certificate generated successfully"
