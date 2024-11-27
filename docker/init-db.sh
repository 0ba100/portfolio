#!/usr/bin/env bash

set -eu

# Create the admin user to prevent using the superuser for everything
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" -d "${POSTGRES_DB}" <<-EOSQL
    CREATE ROLE "${POSTGRES_ADMIN_USER}" WITH
        CREATEDB
        CREATEROLE
        LOGIN
        ENCRYPTED PASSWORD '${POSTGRES_ADMIN_PASSWORD}';
EOSQL

# Values must be quoted to preserve the case of username/password
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_ADMIN_USER" -d "${POSTGRES_DB}" <<-EOSQL
    CREATE DATABASE "${POSTGRES_APP_DB}";
    \c "${POSTGRES_APP_DB}";

    CREATE USER "${POSTGRES_APP_USER}" WITH ENCRYPTED PASSWORD '${POSTGRES_APP_PASSWORD}';
    GRANT CREATE ON SCHEMA public TO "${POSTGRES_APP_USER}";
    GRANT ALL PRIVILEGES ON DATABASE ${POSTGRES_APP_DB} TO "${POSTGRES_APP_USER}";
EOSQL

# Keycloak Database User
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_ADMIN_USER" -d "${POSTGRES_DB}" <<-EOSQL
    CREATE DATABASE ${POSTGRES_KC_DB};
    \c ${POSTGRES_KC_DB};

    CREATE USER "${POSTGRES_KC_USER}" WITH ENCRYPTED PASSWORD '${POSTGRES_KC_PASSWORD}';
    GRANT ALL PRIVILEGES ON DATABASE ${POSTGRES_KC_DB} TO "${POSTGRES_KC_USER}";
    GRANT ALL ON SCHEMA public TO "${POSTGRES_KC_USER}";
    GRANT CREATE ON SCHEMA public TO "${POSTGRES_KC_USER}";
    GRANT USAGE ON SCHEMA public TO "${POSTGRES_KC_USER}";
EOSQL
