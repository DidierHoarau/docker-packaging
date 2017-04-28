#!/bin/bash

if [ "$npm_package_name" == "" ]; then
  echo "Error: Script should be called with npm run packaging:container-run"
  exit 1
fi
. ./docker-packaging/env.sh


ENVIRONMENT="$1"
COMPOSE_FILE_ENV=""
if [ "${ENVIRONMENT}" != "" ]; then
  echo ENVIRONMENT = "${ENVIRONMENT}"
  if [ -f "${PACKAGING_CONFIG}/docker-compose-${ENVIRONMENT}.yml" ]; then
    COMPOSE_FILE_ENV="-f docker-compose-${ENVIRONMENT}.yml"
    echo Using: docker-compose.yml + docker-compose-${ENVIRONMENT}.yml
  fi
fi


# Script to be executed before?
if [ -f ${PACKAGING_CONFIG}/service-run-before.sh ]; then
  ${PACKAGING_CONFIG}/service-run-before.sh
fi


# Start the Docker project
cd ${PACKAGING_CONFIG}
docker-compose \
    -p ${npm_package_name} \
    -f ${PACKAGING_CONFIG}/docker-compose.yml ${COMPOSE_FILE_ENV} \
    up \
    -d \
    --remove-orphans


# Script to be executed after?
if [ -f ${PACKAGING_CONFIG}/service-run-after.sh ]; then
  ${PACKAGING_CONFIG}/service-run-after.sh
fi
