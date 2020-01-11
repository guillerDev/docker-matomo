#!/bin/bash

NGINX_PATH="./nginx-certbot"

while getopts d:e: option
  do
    case "${option}"
    in
    d) DOMAIN=${OPTARG};;
    e) EMAIL=${OPTARG};;
  esac
done

cd "$NGINX_PATH"
./init-letsencrypt.sh -d $DOMAIN -e $EMAIL

echo "### Saving old nginx conf."
mv  ./data/nginx ./data/nginx-OLD
echo "### Copying nginx matomo configuration."
cp -r ../data/nginx ./data

./init-nginxconf.sh -d $DOMAIN

echo "### Copying matomo docker-compose."
cp ../db.env .
cp ../docker-compose.matomo.yml .

echo "### Starting services."
docker-compose -f docker-compose.matomo.yml -f docker-compose.override.yml up -d

echo "### Run this command to find the status: "
echo "docker-compose -f $NGINX_PATH/docker-compose.matomo.yml -f $NGINX_PATH/docker-compose.override.yml ps"
