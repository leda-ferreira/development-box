#!/usr/bin/env bash

# installs apache httpd
apt-get install -y apache2

# enable modules
a2enmod rewrite

# changes webroot
if ! [ -L /var/www ]; then
    if ! [ -d /vagrant/www ]; then
        mkdir /vagrant/www
        cp -r /var/www/* /vagrant/www/
    fi

    rm -rf /var/www
    ln -fs /vagrant/www /var/www
fi
