
FROM nginx:alpine

COPY nginx/conf.d /etc/nginx/conf.d
COPY nginx/htpasswd /etc/www/.htpasswd

RUN RUN wget http://www.adminer.org/latest.php -O /etc/www/index.php