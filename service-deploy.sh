#!/bin/bash

if [ "$npm_package_name" == "" ]; then
  echo "Error: Script should be called with npm run packaging:service-deploy"
  exit 1
fi
. ./docker-packaging/env.sh


# Script to be executed before?
if [ -f ${PACKAGING_CONFIG}/service-deploy-before.sh ]; then
  ${PACKAGING_CONFIG}/service-deploy-before.sh
fi


# Start the Docker project
cd ${PACKAGING_CONFIG}
docker deploy --compose-file ${PACKAGING_CONFIG}/docker-compose-deploy.yml ${npm_package_name}


# Script to be executed after?
if [ -f ${PACKAGING_CONFIG}/service-deploy-after.sh ]; then
  ${PACKAGING_CONFIG}/service-deploy-after.sh
fi
