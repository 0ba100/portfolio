# portfolio

## Development

### Requirements:

- docker
- openssl

### Optional:

- [pwgen](https://github.com/tytso/pwgen) or other password generator
- [mkcert](https://github.com/FiloSottile/mkcert)

### Getting started

Populate an `./.env` file with values from `./default.env`. I recommend using `pwgen -s` for simplicity where passwords are concerned. DB names have [postgres DB name limitations.](https://www.postgresql.org/docs/current/sql-syntax-lexical.html#SQL-SYNTAX-IDENTIFIERS) Since caddy expects a hostname, I would recommend using 443/80 as your external caddy ips.

`KC_HOSTNAME` represents the host to access keycloak locally, e.g. `auth.localhost`. You'll have to update dns host resolution accordingly as keycloak expects this hostname in order to connect.

Run `./scripts/gen-ssl.sh` to generate self-signed ssl certs for caddy to serve keycloak using openssl. These won't be trusted by your browser. Trusting certificates is a process that varies per browser.  If you'd like to try to create and trust the development certs in one command, use the `./scripts/gen-ssl-mkcert.sh` script, which requires mkcert to be installed.

Run `docker compose up` to get the project up and running.
