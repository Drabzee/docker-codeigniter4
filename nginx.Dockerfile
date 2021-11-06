FROM nginx:1.21.3-alpine

COPY ./config/nginx/default.conf /etc/nginx/conf.d/default.conf

COPY ./public /var/www/html/public