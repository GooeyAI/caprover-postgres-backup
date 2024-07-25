## Requirements

1. Server with [caprover](https://caprover.com/) installed and ready to go
2. Postgres database on that server (one-click apps rock!)
3. A google cloud storage bucket with versioning enabled

## Usage

1. Create a caprover app. 
2. Check "Do not expose as web-app"
3. Specify the following environment variables in the App Configs tab ([example](.env.example))
    - `BUCKET_PATH` - The `gs://<bucket>/<filename>.tar.zst` path to the GCS bucket where the db backup should be stored
    - `GOOGLE_APPLICATION_CREDENTIALS_JSON` - A JSON service account key, that has permission to create/replace objects in above bucket.
    - `PGHOST`, `PGPORT`, `PGUSER`, `PGPASSWORD` - Should point to your db
4. Add this github repo in the deployment tab, press force deploy

## Restore

Reference: https://www.postgresql.org/docs/current/continuous-archiving.html

1. Exec into a new container that is running the postgres image
2. Make sure that `$PGDATA` is empty
3. Run this script to download the backup and untar it into the $PGDATA directory
```
gsutil cp gs://<bucket>/<filename>.tar.zst - | tar -I zstd -xvf - -C $PGDATA
```
4. `pg_ctl -D $PGDATA reload`
