
# Get Variable FROM docker-compose
ARG MYSQL_VERSION

FROM mariadb:${MYSQL_VERSION}

RUN chmod +r -R /docker-entrypoint-initdb.d
