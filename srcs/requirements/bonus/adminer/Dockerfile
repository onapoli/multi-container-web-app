FROM debian:buster

RUN apt-get update && apt-get install -y php7.3 php7.3-cli php7.3-common \
    php7.3-mysql wget

RUN mkdir -p /var/adminer

RUN wget https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1.php -O /var/adminer/index.php

EXPOSE 8080

CMD ["php7.3", "-S", "[::]:8080", "-t", "/var/adminer"]