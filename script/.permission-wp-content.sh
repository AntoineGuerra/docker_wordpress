#!/bin/bash
source .env

container_acl_path=/var/www/html/wp-content
acl=755
owner=www-data
group=${owner}

sudo docker exec -ti ${COMPOSE_PROJECT_NAME}_wordpress_1 sh -c \
"chown ${owner}:${group} -R ${container_acl_path}"
echo "Owner changed recursively to ${owner}:${group} of path ${container_acl_path}"
sudo docker exec -ti ${COMPOSE_PROJECT_NAME}_wordpress_1 sh -c \
"chmod ${acl} -R ${container_acl_path}"
echo "ACL ${acl} correctly applied recursively on ${container_acl_path}"
