FROM debian:buster

RUN apt-get update 
RUN apt-get install -y wget libzip-dev apt-transport-https lsb-release ca-certificates git curl software-properties-common
RUN apt-get -y install libxpm4 libxrender1 libgtk2.0-0 libnss3 libgconf-2-4
RUN apt-get -y install -y gconf-service libasound2 libatk1.0-0 libcairo2 libcups2 libfontconfig1 libgdk-pixbuf2.0-0 libgtk-3-0 libnspr4 libpango-1.0-0 libxss1 fonts-liberation libappindicator1 libnss3 lsb-release xdg-utils

### Install NodeJS
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
RUN apt-get install -y nodejs

### Install PHP
RUN wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
RUN echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main"> /etc/apt/sources.list.d/php.list
RUN apt-get update
RUN apt-get install --no-install-recommends -y php7.3 libapache2-mod-php7.3 php7.3-mysql php7.3-curl php7.3-json php7.3-gd php7.3-msgpack php7.3-memcached php7.3-intl php7.3-sqlite3 php7.3-gmp php7.3-geoip php7.3-mbstring php7.3-redis php7.3-xml php7.3-zip php7.3-soap php7.3-igbinary

### Install Composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php \
    && php -r "unlink('composer-setup.php');" \
    && mv composer.phar /usr/bin/composer \
    && chmod +x /usr/bin/composer

### Install YARN
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt update && apt install yarn
run apt-get install g++ build-essential