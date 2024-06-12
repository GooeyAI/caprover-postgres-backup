## Requirements

1. Server with [caprover](https://caprover.com/) installed and ready to go
2. Postgres database on that server (one-click apps rock!)
3. A google cloud storage bucket with versioning enabled

## Usage

1. Create a caprover app. 
2. Check "Do not expose as web-app"
3. Specify the following environment variables in the App Configs tab
    - `BUCKET_PATH` - The `gs://<bucket>/<filename>.dump` path to the GCS bucket where the db dump should be stored
    - `GOOGLE_APPLICATION_CREDENTIALS_JSON` - A JSON service account key, that has permission to create/replace objects in above bucket.
    - `PGHOST`, `PGPORT` `PGDATABASE`, `PGUSER`, `PGPASSWORD` - Should point to your db
4. Add this github repo in the deployment tab, press force deploy

