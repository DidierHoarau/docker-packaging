#!/bin/bash

set -e

if [ "$npm_package_name" == "" ]; then
  echo "Error: Script should be called with npm run packaging:image-build"
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
if [ -f ${PACKAGING_CONFIG}/image-build-before.sh ]; then
  ${PACKAGING_CONFIG}/image-build-before.sh
fi


# Rebuild the Docker project
cd ${PACKAGING_CONFIG}
docker-compose \
    -p ${npm_package_name} \
    -f ${COMPOSE_FILE} \
    build


# Script to be executed after?
if [ -f ${PACKAGING_CONFIG}/image-build-after.sh ]; then
  ${PACKAGING_CONFIG}/image-build-after.sh
fi
