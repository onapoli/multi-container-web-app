FROM debian:buster

ARG FTP_USER \
    FTP_PASS \
    CERTS_ \
    FTP_DOMAIN_NAME

RUN apt-get update && apt-get install -y vsftpd openssl

RUN openssl req -x509 -out "$CERTS_"/certs/"$FTP_DOMAIN_NAME".crt \
	-keyout "$CERTS_"/private/"$FTP_DOMAIN_NAME".key \
	-newkey rsa:2048 -nodes -sha256 -subj "/C=ES/CN=$FTP_DOMAIN_NAME"

COPY ./conf ./conf

RUN sed -i "s|CERTS_|$CERTS_|g" /conf/vsftpd.conf \
    && sed -i "s/FTP_DOMAIN_NAME/$FTP_DOMAIN_NAME/g" /conf/vsftpd.conf

RUN rm -f /etc/vsftpd.conf \
    && mv /conf/vsftpd.conf /etc

RUN useradd -d /var/www/my_website $FTP_USER \
    && echo "$FTP_USER:$FTP_PASS" | chpasswd \
    && usermod -a -G www-data $FTP_USER

RUN echo $FTP_USER > /etc/vsftpd.chroot_list

RUN mkdir -p /var/run/vsftpd/empty

RUN rm -rf /conf

EXPOSE 21

CMD ["/usr/sbin/vsftpd", "/etc/vsftpd.conf"]