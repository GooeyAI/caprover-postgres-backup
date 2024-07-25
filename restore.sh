# avoid logging secrets!
set -e

echo '+ echo "$GOOGLE_APPLICATION_CREDENTIALS_JSON" > serviceAccountKey.json'
echo "$GOOGLE_APPLICATION_CREDENTIALS_JSON" > serviceAccountKey.json

# safe to turn on logging now
set -ex

gcloud auth activate-service-account --key-file serviceAccountKey.json

# restore the database

gsutil cp $BUCKET_PATH - | tar -I zstd -xvf - -C $PGDATA
pg_ctl -D $PGDATA start