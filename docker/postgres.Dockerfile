FROM: postgres:latest

COPY docker/init-db.sh /docker-entrypoint-initdb.d/
