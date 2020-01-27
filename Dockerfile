
FROM nginx

COPY nginx/conf.d /etc/nginx
COPY nginx/htpasswd /etc/www/.htpasswd

RUN apt-get update
RUN apt-get install wget php7 php7-fpm php-mysqli
RUN wget http://www.adminer.org/latest.php -O /etc/www/index.php

EXPOSE 80