set -ex

time pg_basebackup -D - -F tar -X fetch --compress=zstd -P | gsutil cp - $BUCKET_PATH
