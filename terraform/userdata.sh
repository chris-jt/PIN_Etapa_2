#!/bin/bash
apt-get update
apt-get install -y apache2 php libapache2-mod-php
systemctl enable apache2
systemctl start apache2
echo "<?php echo 'Hola Mundo!'; ?>" > /var/www/html/index.php