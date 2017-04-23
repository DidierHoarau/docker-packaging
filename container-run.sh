#!/bin/bash

if [ "$npm_package_name" == "" ]; then
  echo "Error: Script should be called with npm run packaging:container-run"
  exit 1
fi
. ./docker-packaging/env.sh


# Script to be executed before?
if [ -f ${PACKAGING_CONFIG}/container-run-before.sh ]; then
  ${PACKAGING_CONFIG}/container-run-before.sh
fi


# Start the Docker project
cd ${PACKAGING_CONFIG}
docker-compose -p ${npm_package_name} up -d --remove-orphans


# Script to be executed after?
if [ -f ${PACKAGING_CONFIG}/container-run-after.sh ]; then
  ${PACKAGING_CONFIG}/container-run-after.sh
fi
