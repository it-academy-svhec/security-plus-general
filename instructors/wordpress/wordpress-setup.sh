#!/bin/bash
# This should only be used for attack targets and not production instances of WordPress.

apt update
apt install apache2 \
                 ghostscript \
                 libapache2-mod-php \
                 mysql-server \
                 php \
                 php-bcmath \
                 php-curl \
                 php-imagick \
                 php-intl \
                 php-json \
                 php-mbstring \
                 php-mysql \
                 php-xml \
                 php-zip

mkdir -p /srv/www
chown www-data: /srv/www
curl https://wordpress.org/latest.tar.gz | sudo -u www-data tar zx -C /srv/www

# Create the site configuration file for WordPress
tee /etc/apache2/sites-available/wordpress.conf > /dev/null <<EOF
<VirtualHost *:80>
    DocumentRoot /srv/www/wordpress
    <Directory /srv/www/wordpress>
        Options FollowSymLinks
        AllowOverride Limit Options FileInfo
        DirectoryIndex index.php
        Require all granted
    </Directory>
    <Directory /srv/www/wordpress/wp-content>
        Options FollowSymLinks
        Require all granted
    </Directory>
</VirtualHost>
EOF

a2ensite wordpress
a2enmod rewrite
a2dissite 000-default
service apache2 reload

# Set MySQL root password and WordPress DB credentials
MYSQL_ROOT_PASS="your_root_password"
WP_DB="wordpress"
WP_USER="wordpress"
WP_PASS="your_wp_password"

# Start MySQL service
service mysql start

# Run SQL commands to set up WordPress DB and user
mysql -u root -p"$MYSQL_ROOT_PASS" <<EOF
CREATE DATABASE IF NOT EXISTS $WP_DB;
CREATE USER IF NOT EXISTS '$WP_USER'@'localhost' IDENTIFIED BY '$WP_PASS';
GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, ALTER ON $WP_DB.* TO '$WP_USER'@'localhost';
FLUSH PRIVILEGES;
EOF

echo "✅ WordPress MySQL database and user setup complete."

sudo -u www-data cp /srv/www/wordpress/wp-config-sample.php /srv/www/wordpress/wp-config.php

sudo -u www-data sed -i 's/database_name_here/$WP_USER/' /srv/www/wordpress/wp-config.php
sudo -u www-data sed -i 's/username_here/$WP_USER/' /srv/www/wordpress/wp-config.php
sudo -u www-data sed -i 's/password_here/$WB_PASS/' /srv/www/wordpress/wp-config.php

# Enable commands from remote systems
ufw allow 3306
sed -i 's/^bind-address\s*=.*/bind-address = 0.0.0.0/' /etc/mysql/mysql.conf.d/mysqld.cnf
systemctl restart mysql

