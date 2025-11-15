#!/bin/bash

ENS_TARGET_DIRECTORY="/opt/bitnami/keycloak/data/imports"
ENS_SOURCE_DIRECTORY="/tmp"

if [ ! -d "$ENS_TARGET_DIRECTORY" ]; then
  echo "Error: Directory '$ENS_TARGET_DIRECTORY' not found."
  echo "Envsubst will put its result here"
  echo "This directory should be created in Dockerfile."
  exit 1
fi

if [ ! -d "$ENS_SOURCE_DIRECTORY" ]; then
  echo "Error: Directory '$ENS_SOURCE_DIRECTORY' not found."
  echo "Envsubst will take realm files from here"
  echo "This directory should be created in Dockerfile."
  exit 1
fi

for item in "$ENS_SOURCE_DIRECTORY"/*; do
  if [ -f "$item" ]; then
    filename=$(basename "$item")
    envsubst < "$item" > "$ENS_TARGET_DIRECTORY/$filename"
    /opt/bitnami/keycloak/bin/kc.sh import --file "$ENS_TARGET_DIRECTORY/$filename"
    echo "Processed $filename"
  fi
done
