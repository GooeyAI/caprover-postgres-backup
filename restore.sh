# avoid logging secrets!
set -e

echo '+ echo "$GOOGLE_APPLICATION_CREDENTIALS_JSON" > /tmp/serviceAccountKey.json'
echo "$GOOGLE_APPLICATION_CREDENTIALS_JSON" > /tmp/serviceAccountKey.json

# safe to turn on logging now
set -ex

gcloud auth activate-service-account --key-file /tmp/serviceAccountKey.json

# restore the database

gsutil cp $BUCKET_PATH - | tar -I zstd -xvf - -C $PGDATA
pg_ctl -D $PGDATA start

while true;
do
  if pg_isready -h localhost -p 5432;
  then
    echo "Database is ready"
  else
    echo "Database is not ready"
  fi
  sleep 24h
done
