#!/bin/bash

# Ensure script runs with root privileges
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root. Exiting."
    exit 1
fi

echo "Starting user data script..."

# Step 1: Configure DNS (Ensure Google DNS is added)
echo "Updating /etc/resolv.conf..."
echo "nameserver 8.8.8.8" | tee /etc/resolv.conf > /dev/null

# Prevent overwriting by cloud-init
echo "supersede domain-name-servers 8.8.8.8;" | tee -a /etc/dhcp/dhclient.conf > /dev/null

# Step 2: Update packages
echo "Updating packages..."
apt update -y

# Step 3: Install required packages
echo "Installing MariaDB server and required utilities..."
apt install -y mariadb-server rpl curl

# Step 4: Retrieve instance metadata
echo "Fetching instance metadata..."
HOSTNAME=$(curl -s http://169.254.169.254/latest/meta-data/hostname | cut -f 1 -d '.')
LOCAL_IPV4=$(curl -s http://169.254.169.254/latest/meta-data/local-ipv4)

# Step 5: Configure MariaDB
echo "Configuring MariaDB..."

# Secure MariaDB (optional, remove if unnecessary)
mysql -u root -e "
    DELETE FROM mysql.user WHERE User='';
    DROP DATABASE IF EXISTS test;
    DELETE FROM mysql.db WHERE Db='test' OR Db='test_%';
    FLUSH PRIVILEGES;"

# Create database and user
mysql -u root -e "
    CREATE DATABASE wordpressdb;
    GRANT ALL PRIVILEGES ON wordpressdb.* TO 'wordpressuser'@'%' IDENTIFIED BY 'openstack';
    GRANT ALL PRIVILEGES ON wordpressdb.* TO 'wordpressuser'@'localhost' IDENTIFIED BY 'openstack';
    FLUSH PRIVILEGES;"

# Step 6: Bind MariaDB to the instance's local IP
echo "Updating MariaDB bind-address..."
rpl 127.0.0.1 $LOCAL_IPV4 /etc/mysql/mariadb.conf.d/50-server.cnf

# Step 7: Restart services
echo "Restarting MariaDB..."
systemctl restart mariadb

# Step 8: Update /etc/hosts
echo "Updating /etc/hosts..."
echo "$LOCAL_IPV4 $HOSTNAME" >> /etc/hosts

echo "User data script completed successfully!"
