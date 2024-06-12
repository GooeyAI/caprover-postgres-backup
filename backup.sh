set -ex

pg_dump -Fc -f db.dump
gsutil cp file://db.dump "$BUCKET_PATH"
