#!/bin/bash

if [ "$npm_package_name" == "" ]; then
  echo "Error: Script should be called with npm run packaging:service-deploy"
  exit 1
fi
. ./docker-packaging/env.sh


ENVIRONMENT="$1"
COMPOSE_FILE="docker-compose.yml"
if [ "${ENVIRONMENT}" != "" ]; then
  echo ENVIRONMENT = "${ENVIRONMENT}"
  if [ -f "${PACKAGING_CONFIG}/docker-compose-${ENVIRONMENT}.yml" ]; then
    COMPOSE_FILE="docker-compose-${ENVIRONMENT}.yml"
  fi
fi
echo Using: ${COMPOSE_FILE}


# Script to be executed before?
if [ -f ${PACKAGING_CONFIG}/service-deploy-before.sh ]; then
  ${PACKAGING_CONFIG}/service-deploy-before.sh
fi


# Start the Docker project
cd ${PACKAGING_CONFIG}
docker deploy --compose-file ${COMPOSE_FILE} ${npm_package_name}


# Script to be executed after?
if [ -f ${PACKAGING_CONFIG}/service-deploy-after.sh ]; then
  ${PACKAGING_CONFIG}/service-deploy-after.sh
fi
