#!/bin/bash

if [ "$npm_package_name" == "" ]; then
  echo "Error: Script should be called with npm run packaging:container-run"
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
if [ -f ${PACKAGING_CONFIG}/service-run-before.sh ]; then
  ${PACKAGING_CONFIG}/service-run-before.sh
fi


# Start the Docker project
cd ${PACKAGING_CONFIG}
docker-compose \
    -p ${npm_package_name} \
    -f ${COMPOSE_FILE} \
    up \
    -d \
    --remove-orphans


# Script to be executed after?
if [ -f ${PACKAGING_CONFIG}/service-run-after.sh ]; then
  ${PACKAGING_CONFIG}/service-run-after.sh
fi
