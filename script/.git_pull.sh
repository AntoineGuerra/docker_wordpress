#!/bin/bash
color_default='\033[0m'
color_warning='\033[0;33m'
color_info='\033[0;36m'
color_success='\033[0;32m'
color_error='\033[0;31m'


owner=$(whoami)
group=${owner}
system_acl_path=src/site/wp-content


sudo chown ${owner}:${group} -R ${system_acl_path}
echo "Owner changed recursively to ${owner}:${group} of path ${system_acl_path}"
git pull
yarn run permission-wp-content
