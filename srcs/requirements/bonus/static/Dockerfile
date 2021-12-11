FROM debian:buster

ARG CERTS_ \
    STATIC_DOMAIN_NAME \
    STATIC_PORT

RUN apt-get update && apt-get install -y wget openssl

RUN openssl req -x509 -out "$CERTS_"/certs/"$STATIC_DOMAIN_NAME".crt \
	-keyout "$CERTS_"/private/"$STATIC_DOMAIN_NAME".key \
	-newkey rsa:2048 -nodes -sha256 -subj "/C=ES/CN=$STATIC_DOMAIN_NAME"

RUN cd /tmp \
    && wget https://go.dev/dl/go1.17.3.linux-amd64.tar.gz \
    && tar -C /usr/local -xzf go1.17.3.linux-amd64.tar.gz

ENV PATH /usr/local/go/bin:$PATH

ENV GOPATH /go
ENV PATH $GOPATH/bin:$PATH
RUN mkdir -p "$GOPATH/src/static_server" "$GOPATH/bin" && chmod -R 777 "$GOPATH"
WORKDIR "$GOPATH/src/static_server"

COPY ./tools/ .

RUN go mod init && go install

EXPOSE $STATIC_PORT

CMD ["static_server"]