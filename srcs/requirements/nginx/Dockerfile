FROM debian:buster

ARG	CERTS_ \
	DOMAIN_NAME \
	WP_HOST

RUN apt-get update && apt-get install -y nginx openssl

RUN openssl req -x509 -out "$CERTS_"/certs/"$DOMAIN_NAME".crt \
	-keyout "$CERTS_"/private/"$DOMAIN_NAME".key \
	-newkey rsa:2048 -nodes -sha256 -subj "/C=ES/CN=$DOMAIN_NAME"

# COPY THE srcs FOLDER TO ONE OF THE SAME NAME INSIDE THE IMAGE.
COPY ./conf ./conf

# REMOVE THE DEFAULT nginx CONFIGURATION AND APPLY OUR OWN CONFIGURATION FILE
# FOR my_website.
RUN rm /etc/nginx/sites-enabled/default \
	&& mv /conf/my_website.conf /etc/nginx/sites-available/ \
	&& ln -s /etc/nginx/sites-available/my_website.conf /etc/nginx/sites-enabled/

RUN sed -i "s/WP_HOST/$WP_HOST/" /etc/nginx/sites-available/my_website.conf \
	&& sed -i "s|CERTS_|$CERTS_|g" /etc/nginx/sites-available/my_website.conf \
	&& sed -i "s/DOMAIN_NAME/$DOMAIN_NAME/g" /etc/nginx/sites-available/my_website.conf

RUN rm -rf /conf

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]