# Docker compose for wordpress cluster
This docker-compose file will provide a wordpress website with PHP + Apache + MySQL 
 

[![Docker compose Build](https://github.com/AntoineGuerra/docker_wordpress/workflows/{workflow_name}/badge.svg)](https://github.com/AntoineGuerra/docker_wordpress/actions)

## Prerequisites

Docker 1.10, either native or with docker-machine (Toolbox on Windows or Mac OS X : https://www.docker.com/docker-toolbox)

### 1. COPY .env.sample file to .env
```
cp .env.sample .env
```

### 2. Setup env variables
1 env variables is **mandatory** for Global project :
- COMPOSE_PROJECT_NAME : All container will be set with COMPOSE_PROJECT_NAME as name prefix

4 env variables are **mandatory** to set for MySQL :
- MYSQL_ROOT_PASSWORD
- MYSQL_PASSWORD
- MYSQL_DATABASE
- MYSQL_USER

1 env variable is **optional** to set:
- PHP_VERSION (optional, default=7.2.2)

### 3. Setup your MySQL File
Please put your DATABASE.sql file in `src/mysql/sql-entrypoint/`
```
# All files in this directory will be import
cp MY/PATH/TO/DATABASE.sql src/mysql/sql-entrypoint/
```
It will be import in new database just created 

### 4. Put your wordpress site
Please copy you wordpress site directory in `src/site` : 
    
    # This directory will be bind to your local site 
    # Your developments will be live sent to container
    mv PATH/TO/YOUR/WORDPRESS_SITE/* PATH/TO/YOUR/WORDPRESS_SITE/.*  src/site/


### 5. Setup your database informations to wordpress


#####/!\  Your site will be placed in /var/www/html/   /!\ 
Default is : `root /var/www/html/;`

## Launching    

    docker-compose up

Without logs
    
    docker-compose up -d

And then, your own wordpress cluster should be available !

## Usefull commands
Ssh into container 

    docker exec -ti container_id /bin/bash

Print logs:   

    docker logs container_id

## Managing the lifecycle

### Restarting 
Without any data loss, you can safely restart the cluster with

    docker-compose restart

or by CTRL+C and then

    docker-compose up
### Stop 
Without any data loss, you can safely stop the cluster with

    docker-compose stop

or by CTRL+C

### Down 
You can down (stop and remove) all containers with :
    
    docker-compose down
    
You can down (stop and remove) all containers and volumes with :
    
    # This command will remove your DB and all other volumes
    docker-compose down -v
    


### Docker volumes
2 named docker volumes (for mysql data and cluster home) are created and persisted, even when containers are deleted.

To list volumes :

    docker volume ls

To delete volume :
    
    docker volume rm VOLUME_NAME

To copy a file into this volume, for example adding a file

    docker cp PATH/TO/myfile.php YOUR_PROJECT_NAME_php_1:/var/www/html/
    docker cp PATH/TO/myfile.sql YOUR_PROJECT_NAME_mysql_1:/tmp/


### Restarting from scratch
Rebuild and restart with fresh data :
    
    docker-compose down -v 
    docker-compose up --build
