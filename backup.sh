#!/bin/bash

set -eo pipefail

echo "Job started: $(date)"

DATE=$(date +%d%m%Y-%H%M)

# save dump locally (and optionally to AWS S3)
FILENAME="backup-$DATE.tar.gz"
FILE="$TARGET_FOLDER/$FILENAME"

mkdir -p "$TARGET_FOLDER"
mongodump --uri "$MONGO_URI" --gzip --archive="$FILE"
dump_status=$?

if [ $dump_status -eq 0 ]; then
  echo "Mongo Database backup succeeded!"
else
  echo "Postgres Database backup didn't succeed! Exiting."
  exit 1
fi

if [[ -n "$TARGET_S3_FOLDER" ]]; then
    aws s3 cp "$FILE" "$TARGET_S3_FOLDER/$FILENAME"
    upload_status=$?

    if [ $upload_status -eq 0 ]; then
      echo "Mongo Database backup [$FILE] upload to $TARGET_S3_FOLDER succeeded!"
    else
      echo "Postgres Database backup upload didn't succeed! Exiting."
      exit 1
    fi
fi

if [ -n "$HEARTBEAT_URL" ]; then
  curl $HEARTBEAT_URL
fi

echo "Job finished: $(date)"