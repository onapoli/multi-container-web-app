FROM debian:buster

ARG MYSQL_USER \
    MYSQL_USER_PASSWORD \
    MYSQL_DB_NAME \
	MDB_HOST \
	REDIS_HOST \
	REDIS_PORT

RUN apt-get update && apt-get install -y \
    php7.3-fpm php7.3-mysql php-redis php7.3-common wget

RUN mkdir -p /var/run/php

# COPY THE srcs FOLDER TO ONE OF THE SAME NAME INSIDE THE IMAGE.
COPY ./conf ./conf

RUN wget https://wordpress.org/wordpress-5.8.1.tar.gz -P /tmp/wp

# INSTALLATION AND CONFIGURATION OF wordpress IMPORTING OUR OWN
# CONFIGURATION FILES.
# --strip-components=1 DELETES GIVEN NUMBER OF LEADING COMPONENTS (or directories)
# FROM FILE NAMES BEFORE EXTRACTION. IN THIS CASE, DOWNLOADS wordpress CONTENTS IN 
# /var/www/my_website INSTEAD OF /var/www/my_website/wordpress, SO IT COULD BE SAID
# THAT ELIMINATES A DIRECTORY LEVEL FROM THE EXTRACTED FILES.
# -C CAUSES THE COMMAND TO EXECUTE INSIDE THE SPECIFIED PATH INSTEAD OF THE CURRENT
# WORKING DIRECTORY. FINALLY, ALL FILES' PERMISSIONS UNDER my_website
# DIRECTORY ARE MODIFIED TO ALLOW THE OWNER TO READ, WRITE AND EXECUTE ANY OF THEM,
# AND USER GROUPS AND OTHERS ONLY READ AND EXECUTE. AND THEN THE OWNER OF THAT
# SAME FOLDER IS CHANGED TO www-data USER AND GROUP, WHICH IS NGINX'S DEFAULT USER.
RUN mkdir -p /var/www/my_website \
	&& tar -xzf /tmp/wp/wordpress-5.8.1.tar.gz --strip-components=1 -C /var/www/my_website \
	&& mv /conf/wp-config.php /var/www/my_website \
	&& chmod -R 775 /var/www/my_website \
	&& chown -R www-data:www-data /var/www/my_website

RUN sed -i "s/'MYSQL_USER'/'$MYSQL_USER'/" /var/www/my_website/wp-config.php \
	&& sed -i "s/MYSQL_USER_PASSWORD/$MYSQL_USER_PASSWORD/" /var/www/my_website/wp-config.php \
	&& sed -i "s/MYSQL_DB_NAME/$MYSQL_DB_NAME/" /var/www/my_website/wp-config.php \
	&& sed -i "s/MDB_HOST/$MDB_HOST/" /var/www/my_website/wp-config.php \
	&& sed -i "s/REDIS_HOST_VAL/$REDIS_HOST/" /var/www/my_website/wp-config.php \
	&& sed -i "s/REDIS_PORT_VAL/$REDIS_PORT/" /var/www/my_website/wp-config.php

RUN mv /conf/www.conf /etc/php/7.3/fpm/pool.d/www.conf

# INSTALL wp-redis REDIS PLUGIN

COPY ./tools ./tools

RUN mv /tools/object-cache.php /var/www/my_website/wp-content/

# REMOVES THE UNNECESARY FOLDER WE CREATED.
RUN rm -rf /tmp/wp /conf

EXPOSE 9000

CMD ["/usr/sbin/php-fpm7.3", "-F"]