#!/usr/bin/env bash

# adds third-party PPA
LC_ALL=C.UTF-8 add-apt-repository -y ppa:ondrej/php

# updates the catalogs
apt-get update

# installs php
apt-get install -y php7.1-mbstring php7.1-bcmath php7.1-readline php7.1-json php7.1-cli php-common php7.1-common php7.1-dev php7.1-gmp php7.1-intl php7.1-gd php7.1-mysql php7.1-pgsql php7.1-sqlite php7.1-curl php7.1-xsl php7.1-soap php7.1-mcrypt libapache2-mod-php7.1

# installs composer
curl -sS https://getcomposer.org/installer | sudo -H php -- --install-dir=/usr/local/bin --filename=composer

# installs global dependency
composer global require "fxp/composer-asset-plugin:~1.3"
