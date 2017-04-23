#!/bin/bash


export PROJECT_NAME=${npm_package_name}_${npm_package_version}
export PROJECT_DIR=`pwd`

export PACKAGING_CONFIG="$PROJECT_DIR/docker-packaging-config"

export PACKAGING_FILES="$PACKAGING_CONFIG/files"


# Checks
if [ ! -d "${PACKAGING_CONFIG}" ]; then
  echo "Folder not found: ${PACKAGING_CONFIG}"
  exit 1
fi
if [ ! -f "${PACKAGING_CONFIG}/docker-compose.yml" ]; then
  echo "Docker Compose file not found: ${PACKAGING_CONFIG}/docker-compose.yml"
  exit 1
fi
