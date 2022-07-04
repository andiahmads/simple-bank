#!/bin/sh

set -e


echo "run db migration"

# source /app/app.env

/app/migrate -path /app/migration -database "postgresql://root:V27NOILEHf9@simple-bank.cwkc7me9fnj5.ap-southeast-3.rds.amazonaws.com:5432/simple_bank" -verbose up


echo "start the app"
exec "$@"
