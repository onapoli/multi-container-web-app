# multi-container-web-app
Multi container web app using Docker-Compose

### INSTRUCTIONS

#### Installation

Install [docker](https://docs.docker.com/get-docker/) and [docker-compose](https://docs.docker.com/compose/install/)

#### Environment Variables

Add your own *.env* file at the root of the *srcs* directory setting your own values for the following docker environment variables:

```
DOMAIN_NAME=value
# certificates
CERTS_=value
# MYSQL SETUP
MYSQL_ROOT_PASSWORD=value
MYSQL_ADMIN_USER=value
MYSQL_ADMIN_USER_PASSWORD=value
MYSQL_USER=value
MYSQL_USER_PASSWORD=value
MYSQL_DB_NAME=value
# WP SETUP
MDB_HOST=db:3306
REDIS_HOST=redis
REDIS_PORT=6379
# NGINX SETUP
WP_HOST=wp:9000
# BONUS
# FTP
FTP_USER=value
FTP_PASS=value
FTP_DOMAIN_NAME=value
# STATIC
STATIC_DOMAIN_NAME=value
STATIC_PORT=value
# REGISTRY
REGISTRY_DOMAIN_NAME=value
REGISTRY_PORT=value
```

#### Build images and execute containers

Run `make` or `make debug` from the directory where *Makefile* is located.

#### Stop and clean containers

Run `make clean` from the directory where *Makefile* is located.

#### Delete docker images

This project creates the following docker images in your system:

- ftp
- mariadb
- registry
- static
- nginx
- redis
- wordpress
- adminer
- debian

From these, the only official image that is downloaded from the official [Docker Hub](https://hub.docker.com/) is debian. The rest are all made by me using *Dockerfiles*. It is important to note, that all the custom images that I made, with the exception of ftp and static, have an official and more secure version that can be downloaded from **Docker Hub**, like [redis](https://hub.docker.com/_/redis).

To delete local docker images individually:

1. Run `docker image ls`
2. Copy the *IMAGE ID* of the image to remove.
3. Run `docker image rm IMAGE_ID` replacing IMAGE_ID with the value copied previously.

To delete more than one local image at a time:

1. Run `docker image ls`
2. Copy and paste all the *IMAGE ID* of the images to delete in this command `docker rmi IMAGE_ID IMAGE_ID IMAGE_ID` replacing each IMAGE_ID with each copied valued. Add as much *IMAGE ID* as needed.

To remove all local docker images from your system: ***Be careful with this command, it will remove every docker image in your system, including others not related to this project.***

Run `docker rmi -f $(docker images -aq)`

#### Uninstall

To uninstall docker and/or docker-compose, look at the bottom of the installation page/s for your system.
