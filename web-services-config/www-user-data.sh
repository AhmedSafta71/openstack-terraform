#!/bin/bash

# Ensure script runs with root privileges
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root. Exiting."
    exit 1
fi

echo "Starting user data script..."

# Step 1: Configure DNS
echo "Updating /etc/resolv.conf..."
echo "nameserver 8.8.8.8" | tee /etc/resolv.conf > /dev/null
echo "supersede domain-name-servers 8.8.8.8;" | tee -a /etc/dhcp/dhclient.conf > /dev/null

# Step 2: Update package lists and upgrade system
echo "Updating package lists..."
apt update -y
apt upgrade -y
apt --fix-broken install -y

# Step 3: Install required packages (one per line)
echo "Installing Apache2..."
apt install -y apache2

echo "Installing MySQL client..."
apt install -y mysql-client

echo "Installing rpl..."
apt install -y rpl

echo "Installing jshon..."
apt install -y jshon

echo "Installing PHP..."
apt install -y php

echo "Installing PHP-MySQL..."
apt install -y php-mysql

echo "Installing PHP-Curl..."
apt install -y php-curl

echo "Installing PHP-GD..."
apt install -y php-gd

echo "Installing PHP-Pear..."
apt install -y php-pear

echo "Installing PHP-Imagick..."
apt install -y php-imagick

echo "Installing PHP-IMAP..."
apt install -y php-imap

echo "Installing PHP-Mcrypt..."
apt install -y php-mcrypt

echo "Installing PHP-Recode..."
apt install -y php-recode

echo "Installing PHP-Tidy..."
apt install -y php-tidy

echo "Installing PHP-XMLRPC..."
apt install -y php-xmlrpc

echo "Installing wget..."
apt install -y wget

echo "Installing unzip..."
apt install -y unzip

# Step 4: Fetch instance metadata
echo "Fetching instance metadata..."
HOSTNAME=$(curl -s http://169.254.169.254/latest/meta-data/hostname | cut -f 1 -d '.')
LOCAL_IPV4=$(curl -s http://169.254.169.254/latest/meta-data/local-ipv4)
DB_SERVER=10.10.0.25

# Step 5: Update /etc/hosts
echo "Updating /etc/hosts..."
echo "$LOCAL_IPV4 $HOSTNAME" >> /etc/hosts

# Step 6: Download and configure WordPress
echo "Downloading and setting up WordPress..."
cd /var/www/html
wget -q http://wordpress.org/latest.tar.gz
tar xzvf latest.tar.gz --strip-components=1
rm latest.tar.gz

# Configure wp-config.php
cp wp-config-sample.php wp-config.php
rpl database_name_here wordpressdb wp-config.php
rpl username_here wordpressuser wp-config.php
rpl password_here openstack wp-config.php
rpl localhost $DB_SERVER wp-config.php

# Set correct permissions
chown -R www-data:www-data /var/www/html/
chmod -R 755 /var/www/html/
rm -rf /var/www/html/index.html

# Step 7: Enable Apache modules and restart services
echo "Configuring Apache..."
a2enmod headers
a2enmod rewrite
systemctl restart apache2

echo "User data script execution completed!"
