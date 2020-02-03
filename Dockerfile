FROM nginx

COPY nginx/adminer.conf /etc/nginx/conf.d/
COPY nginx/htpasswd /etc/nginx/conf.d/.htpasswd
COPY nginx/fastcgi_params /etc/nginx/fastcgi_params
COPY nginx/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN rm /etc/nginx/conf.d/default.conf

RUN apt-get update
RUN apt-get install -y wget php7.3 php7.3-fpm php-mysqli supervisor
RUN mkdir -p /etc/www
RUN wget -x http://www.adminer.org/latest.php -O /etc/www/index.php

COPY nginx/www.conf /etc/php/7.3/fpm/pool.d/www.conf

EXPOSE 80