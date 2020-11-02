# Образ с DockerHub, включает Apache и PHP
FROM php:7.4-apache
# Сообщаем, какие порты контейнера слушать
EXPOSE 80

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \ 
    && php composer-setup.php --install-dir=/usr/local/bin --filename=composer \
    && php -r "unlink('composer-setup.php');"

RUN apt-get update
RUN apt-get install -y \
    git \
    mc \
    r-base \
    libzip-dev

RUN docker-php-ext-install mysqli 

RUN rm -rf /var/lib/apt/lists/* 