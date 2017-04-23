#!/bin/bash

if [ "$npm_package_name" == "" ]; then
  echo "Error: Script should be called with npm run packaging:prepare"
  exit 1
fi
. ./docker-packaging/env.sh


# Call Custom file if exist
if [ -f ${PACKAGING_CONFIG}/prepare.sh ]; then
  ${PACKAGING_CONFIG}/prepare.sh
else
  echo "No ${PACKAGING_CONFIG}/prepare.sh script. Skipping."
fi
