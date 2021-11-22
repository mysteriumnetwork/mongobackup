#!/bin/bash

set -e

export MONGO_URI=${MONGO_URI:-mongodb://mongo:27017}
export TARGET_FOLDER=${TARGET_FOLDER-/backup}   # can be set to null

# Optional env vars:
# - TARGET_S3_FOLDER
# - AWS_ACCESS_KEY_ID
# - AWS_SECRET_ACCESS_KEY
# - AWS_ENDPOINT_FILE

if [ -n "$AWS_ENDPOINT_FILE" ]; then
  if [ ! -e "$AWS_ENDPOINT_FILE" ]; then
      echo "$AWS_ENDPOINT_FILE file doesn't exist. More info here https://www.scaleway.com/en/docs/storage/object/api-cli/object-storage-aws-cli/. Exiting"
      exit
  fi

  cp $AWS_ENDPOINT_FILE /root/.aws/config
fi

echo "[default]
aws_access_key_id=$AWS_KEY_ID
aws_secret_access_key=$AWS_KEY
region=nl-ams" > /root/.aws/credentials

exec /backup.sh