
# Get Variable FROM docker-compose
ARG MYSQL_VERSION

FROM mysql:${MYSQL_VERSION}

RUN chmod +r -R /docker-entrypoint-initdb.d
