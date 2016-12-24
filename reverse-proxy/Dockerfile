FROM ubuntu:16.10

RUN apt-get update && apt-get install nginx -y

COPY conf/nginx.conf /etc/nginx/nginx.conf

ENTRYPOINT nginx -s reload && service nginx start