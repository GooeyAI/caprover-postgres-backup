pg_isready && pg_ctl -D $PGDATA stop && echo "Stopped running database..."

echo "Deleting existing DB and restoring from $BUCKET_PATH"
rm -rf $PGDATA/*
gsutil cp $BUCKET_PATH - | tar -I zstd -xvf - -C $PGDATA

chmod 0700 $PGDATA

pg_ctl -D $PGDATA start

if pg_isready -h localhost -p 5432;
then
  echo "Database is ready"
else
  echo "Database is not ready"
fi
