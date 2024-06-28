# create a docker network
docker network create prestashop-net

# (if MacOS) enable mysql 
docker pull --platform linux/x86_64/v8 mysql

# (if MacOS) set default platform
export DOCKER_DEFAULT_PLATFORM=linux/x86_64/v8

# deploy mysql
docker run -ti -p 3307:3306 --network prestashop-net \
    --name some-mysql \
    -e MYSQL_ROOT_PASSWORD=admin \
    -d mysql \
    --character-set-server=utf8 \
    --sql-mode=ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION

# create a database - wait a few seconds before
docker exec -it some-mysql mysql -u root -p'admin' \
    -e "CREATE DATABASE prestashop"

# deploy prestashop
docker run -ti --name some-prestashop --network prestashop-net \
    -e DB_SERVER=some-mysql \
    -e PS_INSTALL_AUTO=1 \
    -p 8080:80 \
    -d prestashop/prestashop:latest

docker exec \
    -it some-prestashop \
    "rm -rf /var/www/html/install"
