FROM debian:buster

ARG MYSQL_ROOT_PASSWORD \
	MYSQL_ADMIN_USER \
    MYSQL_ADMIN_USER_PASSWORD \
	MYSQL_USER \
    MYSQL_USER_PASSWORD \
    MYSQL_DB_NAME

RUN apt-get update && apt-get install -y default-mysql-server

COPY ./conf ./conf

RUN sed -i "s/MYSQL_ROOT_PASSWORD/$MYSQL_ROOT_PASSWORD/" /conf/root_creds.sql \
	&& sed -i "s/'MYSQL_ADMIN_USER'/'$MYSQL_ADMIN_USER'/g" /conf/root_creds.sql \
	&& sed -i "s/MYSQL_ADMIN_USER_PASSWORD/$MYSQL_ADMIN_USER_PASSWORD/" /conf/root_creds.sql \
	&& sed -i "s/'MYSQL_USER'/'$MYSQL_USER'/g" /conf/wp_db.sql \
	&& sed -i "s/MYSQL_USER_PASSWORD/$MYSQL_USER_PASSWORD/" /conf/wp_db.sql \
	&& sed -i "s/MYSQL_DB_NAME/$MYSQL_DB_NAME/g" /conf/wp_db.sql

RUN mv /conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

RUN service mysql start \
	&& mysql < /conf/wp_db.sql \
	&& mysql < /conf/root_creds.sql

# REMOVES THE UNNECESARY FOLDER WE CREATED.
RUN rm -rf /conf

EXPOSE 3306

CMD ["mysqld"]