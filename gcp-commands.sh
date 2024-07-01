# login
gcloud init

# Enable Google Cloud SQL
gcloud services enable sqladmin.googleapis.com

# set variables
MYSQL_NAME=
DATABASE_NAME=
DB_ROOT_PASSWORD=
REGION=us-central1
PROJECT_ID=


# region us-central1
gcloud sql instances create $MYSQL_NAME  --database-version=MYSQL_8_0 \
--region=$REGION \
--tier=db-f1-micro  \
--root-password=$DB_ROOT_PASSWORD \
--database-flags=^+^character-set-server=utf8+default-authentication-plugin=mysql_native_password+sql-mode=ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION

# create a cloud sql auth proxy
cloud_sql_proxy -instances=$PROJECT_ID:$REGION:$MYSQL_NAME=tcp:3306

# create the prestashop database
gcloud sql databases create $DATABASE_NAME \
--instance=$MYSQL_NAME \
--charset=UTF_8
