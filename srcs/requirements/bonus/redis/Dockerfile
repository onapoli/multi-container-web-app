FROM debian:buster

ARG REDIS_HOST \
    REDIS_PORT

RUN apt-get update && apt-get install -y redis-server

COPY ./conf /tmp/conf

RUN rm -f /etc/redis/redis.conf && mv /tmp/conf/redis.conf /etc/redis

RUN sed -i "s/REDIS_HOST/$REDIS_HOST/" /etc/redis/redis.conf \
    && sed -i "s/REDIS_PORT/$REDIS_PORT/" /etc/redis/redis.conf

EXPOSE $REDIS_PORT

CMD ["redis-server", "/etc/redis/redis.conf"]