#!/usr/bin/env bash

# Locale
sudo locale-gen en_US en_US.UTF-8 tr_TR.UTF-8
sudo dpkg-reconfigure locales

# Define MySQL root password
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'

# Update APT
sudo apt-get update -y

# Install PHP, Apache2, Mysql, PhpMyAdmin, Memcached.
sudo apt-get install -y vim curl git python-software-properties \
			php5 php5-curl php5-gd php5-mcrypt php5-dev php-pear php5-xdebug \
			apache2 libapache2-mod-php5 \
			mysql-server-5.5 php5-mysql phpmyadmin \
			memcached libmemcached-dev
			
# Install MongoDB
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
echo "deb http://repo.mongodb.org/apt/ubuntu "$(lsb_release -sc)"/mongodb-org/3.2 multiverse" \
	| sudo tee /etc/apt/sources.list.d/mongodb.list

sudo apt-get install -y mongodb-org=3.2.10 \
			mongodb-org-server=3.2.10 \
			mongodb-org-shell=3.2.10 \
			mongodb-org-mongos=3.2.10 \
			mongodb-org-tools=3.2.10

# Install PECL and PHP Extensions.
sudo apt-get install -y libpcre3-dev libsasl2-dev pkg-config

sudo pecl update-channels
yes | sudo pecl install APC-3.1.13 apcu-4.0.10 memcache-2.2.7 mongo-1.6.14 zendopcache-7.0.5
yes no --disable-memcached-sasl | sudo pecl install memcached-2.2.0

echo "extension=memcache.so" | sudo tee /etc/php5/conf.d/memcache.ini
echo "extension=memcached.so" | sudo tee /etc/php5/conf.d/memcached.ini
echo "extension=mongo.so" | sudo tee /etc/php5/conf.d/mongo.ini

cat << EOF | sudo tee -a /etc/php5/conf.d/xdebug.ini
xdebug.scream=1
xdebug.cli_color=1
xdebug.show_local_vars=1
EOF

# Install Composer
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer

# Make Apache configs
sudo a2enmod rewrite

sudo sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php5/apache2/php.ini
sudo sed -i "s/display_errors = .*/display_errors = On/" /etc/php5/apache2/php.ini

sudo service apache2 stop
sudo rm /var/lock/apache2 -rf

sudo sed -i 's/APACHE_RUN_USER=www-data/APACHE_RUN_USER=vagrant/' /etc/apache2/envvars
sudo sed -i 's/APACHE_RUN_GROUP=www-data/APACHE_RUN_GROUP=vagrant/' /etc/apache2/envvars

sudo service apache2 start