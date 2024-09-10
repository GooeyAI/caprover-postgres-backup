set -ex

time pg_basebackup -D - -F tar -X fetch --compress=zstd --max-rate=128M -P | gsutil cp - $BUCKET_PATH
