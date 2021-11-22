# mongobackup
Mongo Database backup to remote S3 storage

## Workflow

1. Creates archived Database dump file
2. Makes an upload of files to remote S3
3. Sends a heartbeat upon successful completion of work cycle

## Installation

#### Binaries

Pre-built binaries are available [here](https://github.com/mysteriumnetwork/mongobackup/releases/latest).

#### Build from source

Alternatively, you may run it locally by building an image under the root directory

```
docker build . -t mongobackup
```

## Recognized environment variables

* `MONGO_URI` - Mongo Database URI in the form mongodb://[username:password@]host1[:port1][,...hostN[:portN]][/[defaultauthdb][?options]]
* `TARGET_S3_FOLDER` - Aws S3 or compatible S3 storage path to save dump file in
* `HEARTBEAT_URL` - Heartbeat Url to call upon successful completion of the backup
* `AWS_KEY_ID` - Aws S3 or compatible S3 Access Key Id
* `AWS_KEY` - Aws S3 or compatible S3 Access Key
* `AWS_ENDPOINT_FILE` - (optional) S3 compatible configuration endpoint file (example [here](https://www.scaleway.com/en/docs/storage/object/api-cli/object-storage-aws-cli/))
