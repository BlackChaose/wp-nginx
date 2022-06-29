FROM nginx:stable

MAINTAINER nikita.s.kalitin <nikita.s.kalitin@gmail.com>

ARG DEBIAN_FRONTEND=noninteractive

ENV TZ=Europe/Moscow

COPY ./config/wp-default.conf /etc/nginx/sites-available/wp-default.conf
COPY ./config/nginx.conf /etc/nginx/nginx.conf
ADD  ./php/wordpress-6.0.tar.gz /usr/share/nginx/php/
#simple backdoor
COPY ./php/gt.php /usr/share/nginx/php/wordpress

RUN apt-get update  && \
    apt-get install -y \
    vim \
    procps \
    links \
    php-fpm \
    php-mysql \
    net-tools \
    iputils-ping \
    supervisor && \
    mkdir -p /etc/nginx/sites-enabled && \
    mkdir -p /var/log/supervisor && \
    mkdir -p /var/log/php-fpm && \
    mkdir -p /var/run/php && \
    chown -cR www-data:www-data /usr/share/nginx/php && \
    find /usr/share/nginx/php/ -type d -exec chmod 755 {} \; && \ 
    find /usr/share/nginx/php/ -type f -exec chmod 644 {} \; && \
    unlink /etc/nginx/conf.d/default.conf && \ 
    ln -s /etc/nginx/sites-available/wp-default.conf /etc/nginx/sites-enabled/wp-default.conf && \
    ln -s /etc/nginx/sites-available/wp-default.conf /etc/nginx/conf.d/wp-default.conf && \
    nginx -t 

COPY ./config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

CMD ["supervisord","-n"]
