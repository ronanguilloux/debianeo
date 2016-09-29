FROM debian:jessie
MAINTAINER Ronan Guilloux <ronan.guilloux@gmail.com>
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && \
    apt-get -yq install \
        sudo curl git imagemagick supervisor vim wget
RUN echo "deb http://packages.dotdeb.org jessie all" > /etc/apt/sources.list.d/dotdeb.list
RUN wget https://www.dotdeb.org/dotdeb.gpg && apt-key add dotdeb.gpg
RUN apt-get update && \
    apt-get -yq install \
        mysql-server apache2 libapache2-mod-php7.0 php7.0 php7.0-cli \
        php7.0-cli php7.0-apcu php7.0-mysql php7.0-mongo php7.0-xml php7.0-zip \
        php7.0-curl php7.0-intl php7.0-mbstring php7.0-imagick php7.0-gd php7.0-mcrypt


RUN apt-get clean && apt-get -yq autoclean && apt-get -yq autoremove && \
    rm -rf rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN sudo useradd docker --shell /bin/bash --create-home \
  && sudo usermod -a -G sudo docker \
  && echo 'ALL ALL = (ALL) NOPASSWD: ALL' >> /etc/sudoers \
  && echo 'docker:secret' | chpasswd

ADD docker/install-composer.sh /install-composer.sh
RUN sudo chmod +x /install-composer.sh && /install-composer.sh && rm /install-composer.sh

RUN sed -i "s/;date.timezone =/date.timezone = Europe\/Paris/" /etc/php/7.0/cli/php.ini && \
    sed -i "s/;date.timezone =/date.timezone = Europe\/Paris/" /etc/php/7.0//apache2/php.ini && \
    sed -i "s/memory_limit = .*/memory_limit = 2G/" /etc/php/7.0//cli/php.ini && \
    sed -i "s/memory_limit = .*/memory_limit = 512M/" /etc/php/7.0//apache2/php.ini

RUN a2enmod rewrite && \
    echo "ServerName localhost" >> /etc/apache2/apache2.conf

RUN sed -i "s/export APACHE_RUN_USER=www-data/export APACHE_RUN_USER=docker/" /etc/apache2/envvars && \
    sed -i "s/export APACHE_RUN_GROUP=www-data/export APACHE_RUN_GROUP=docker/" /etc/apache2/envvars && \
    chown -R docker: /var/lock/apache2

EXPOSE 80 22 3306

ADD docker/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

USER docker
WORKDIR /home/docker/
