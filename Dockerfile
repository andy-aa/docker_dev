# Образ с DockerHub, включает Apache и PHP
FROM php:7.4-apache
# Сообщаем, какие порты контейнера слушать
EXPOSE 80
EXPOSE 22

RUN php -r "readfile('http://getcomposer.org/installer');" | php -- --install-dir=/usr/bin/ --filename=composer

RUN apt-get update
RUN apt-get install -y \
    git \
    mc \
    r-base \
    libzip-dev \
    openssh-server \
    sudo

RUN cd /etc/ssh && ssh-keygen -A

RUN docker-php-ext-install mysqli 

RUN rm -rf /var/lib/apt/lists/* 

RUN useradd -m andrei && usermod -G sudo andrei && echo "andrei:andrei" | chpasswd

COPY ./docker-php-entrypoint /usr/local/bin/docker-php-entrypoint
