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
    libzip-dev \
    openssh-server \
    sudo

RUN cd /etc/ssh && ssh-keygen -A

RUN docker-php-ext-install mysqli 

RUN rm -rf /var/lib/apt/lists/* 

COPY ./startup.sh /root/startup.sh
RUN chmod 750 /root/startup.sh

RUN useradd -m andrei && usermod -G sudo andrei && echo "andrei:andrei" | chpasswd

CMD ["/root/startup.sh","mysqld_safe"]