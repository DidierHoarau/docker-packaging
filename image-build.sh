#!/bin/bash

set -e

if [ "$npm_package_name" == "" ]; then
  echo "Error: Script should be called with npm run packaging:build-image"
  exit 1
fi
. ./docker-packaging/env.sh


# Rebuild the Docker project
cd $PACKAGING_CONFIG
docker-compose -p ${npm_package_name} build
