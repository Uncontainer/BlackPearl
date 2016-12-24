FROM ubuntu:16.10

RUN apt-get update && apt-get install nginx -y

COPY conf/nginx.conf /etc/nginx/nginx.conf

ENTRYPOINT service nginx restart