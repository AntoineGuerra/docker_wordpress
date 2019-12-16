#!/bin/bash
color_default='\033[0m'
color_warning='\033[0;33m'
color_info='\033[0;36m'
color_success='\033[0;32m'
color_error='\033[0;31m'

check_docker_cp_result() {
    if [[ $? == 0 ]]
    then
        echo -e "${color_success}SQL dump successfully exported in ${dump_path}/${MYSQL_DATABASE}.sql${color_default}"
    else
        echo -e "${color_error}Cannot export SQL dump of container: ${container}${color_default}"
        sudo docker exec -ti ${container} sh -c "ls /tmp/${MYSQL_DATABASE}.sql" 1>/dev/null
        if [[ $? == 0 ]]
        then
            echo -e "${color_info}Dump file exist in container: ${container} path: /tmp/${MYSQL_DATABASE}.sql${color_default}"
            if [[ ! -d "${dump_path}" ]]
            then
                mkdir ${dump_path}
                if [[ $? != 0 ]]
                then
                    echo -e "${color_error}Cannot create directory ${dump_path} with $(whoami) user${color_default}"
                    exit 1
                else
                    echo -e "${color_successfully}Directory ${dump_path} Created${color_default}"
                    echo "*" > ${dump_path}/.gitignore
                    echo "!.gitignore" >> ${dump_path}/.gitignore
                    sudo docker cp ${container}:/tmp/${MYSQL_DATABASE}.sql ${dump_path}/
                    check_docker_cp_result
                fi
            fi
        else
            echo -e "${color_error}Please check your database information in .env file${color_default}"
            exit 1
        fi
    fi
}

source .env

container=${COMPOSE_PROJECT_NAME}_mysql_1
dump_path=$(pwd)/src/mysql/dumps

sudo docker exec -ti ${container} sh -c \
"mysqldump -u ${MYSQL_USER} -p${MYSQL_PASSWORD} ${MYSQL_DATABASE} > /tmp/${MYSQL_DATABASE}.sql"

if [[ $? == 0 ]]
then
    echo -e "${color_info} SQL dump successfully created in container (/tmp/${MYSQL_DATABASE}.sql)${color_default}"
else
    echo -e "${color_error} Cannot create SQL dump (${MYSQL_DATABASE}.sql) in container: ${container} ${color_default}"
    if [[ $(docker ps | grep ${container}) == "" ]]
    then
        echo -e "${color_error}Please be sure container ${container} is running or name haven’t changed in .env file"
    fi
    exit 1
fi

sudo docker cp ${container}:/tmp/${MYSQL_DATABASE}.sql ${dump_path}/
check_docker_cp_result
