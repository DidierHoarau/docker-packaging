#!/bin/bash

set -e

if [ "$npm_package_name" == "" ]; then
  echo "Error: Script should be called with npm run packaging:build-image"
  exit 1
fi
. ./docker-packaging/env.sh


# Script to be executed before?
if [ -f ${PACKAGING_CONFIG}/image-build-before.sh ]; then
  ${PACKAGING_CONFIG}/image-build-before.sh
fi


# Rebuild the Docker project
cd $PACKAGING_CONFIG
docker-compose -p ${npm_package_name} build


# Script to be executed after?
if [ -f ${PACKAGING_CONFIG}/image-build-after.sh ]; then
  ${PACKAGING_CONFIG}/image-build-after.sh
fi
