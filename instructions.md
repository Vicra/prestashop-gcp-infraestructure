# Docker Configuration

Setting up local environment for Prestashop 
Using MacOS M1 Pro

App name: test-ecommerce
Database name: test-database

## Create a network for containers to communicate
docker network create prestashop-network

## If using M1 or M2 chip, Enable the linux platform
docker pull --platform linux/x86_64 mysql (not sure if its required)
docker pull --platform linux/x86_64/v8 mysql

## Export default platform
export DOCKER_DEFAULT_PLATFORM=linux/x86_64/v8
export DOCKER_DEFAULT_PLATFORM=linux/amd64 (not sure if its required)

## Launch mysql 5.7 container
docker run 
  -ti 
  --name [test-database]
  --network prestashop-network  
  -e MYSQL_ROOT_PASSWORD=admin 
  -p 3307:3306 
  -d mysql:5.7

## launch prestashop container
docker run 
  -ti 
  --name [test-ecommerce]
  --network [prestashop-network]
  -e DB_SERVER=[test-database]
  -p 8080:80 
  -d prestashop/prestashop:latest

Go to workbench and create the schema
prestashop

Configure Database
name: prestashop
user: root
passw: [password]
server address: techdeals-db (same as the one when launching the container)

Go to docker instance, select Exec tab
Delete the install folder located at

    rm -rf /var/www/html/install

Rename the admin folder (to allow being able to start configuring prestashop admin)
  
    mv /var/www/html/admin /var/www/html/admin-app-name

On the browser go to the /admin named folder for example

    http://localhost:8080/admin-app-name/

# Configure Prestashop Admin
## Change Currency
Mejoras>Internacional>Localizacion>Monedas
	Agregar Lempiras

Mejoras>Internacional>Localizacion>Localizacion
	Moneda por defecto

# Cambiar idioma (del sitio) por defecto a español
Localizacion>Idiomas
	Desactivar ingles
