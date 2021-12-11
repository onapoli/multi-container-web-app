FROM debian:buster

ARG CERTS_ \
    REGISTRY_DOMAIN_NAME \
    REGISTRY_PORT

RUN apt-get update && apt-get install -y openssl

RUN openssl req -x509 -out "$CERTS_"/certs/"$REGISTRY_DOMAIN_NAME".crt \
	-keyout "$CERTS_"/private/"$REGISTRY_DOMAIN_NAME".key \
	-newkey rsa:2048 -nodes -sha256 -subj "/C=ES/CN=$REGISTRY_DOMAIN_NAME"

COPY ./tools/registry /bin/registry

COPY ./config/config-example.yml /etc/docker/registry/config.yml

RUN chmod 700 /bin/registry

RUN sed -i "s/REGISTRY_PORT/$REGISTRY_PORT/" /etc/docker/registry/config.yml \
    && sed -i "s|CERTS_|$CERTS_|g" /etc/docker/registry/config.yml \
    && sed -i "s/REGISTRY_DOMAIN_NAME/$REGISTRY_DOMAIN_NAME/g" /etc/docker/registry/config.yml

EXPOSE $REGISTRY_PORT

CMD ["/bin/registry", "serve", "/etc/docker/registry/config.yml"]