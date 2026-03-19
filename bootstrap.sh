#!/bin/bash

# Змінні, що передаються через templatefile
WEB_PORT=${web_port}
DOCUMENT_ROOT=${document_root}
SERVER_NAME=${server_name}

# Оновлення системи
apt-get update -y
apt-get upgrade -y

# Встановлення Apache2
apt-get install -y apache2

# Створення DocumentRoot
mkdir -p ${DOCUMENT_ROOT}
chown -R www-data:www-data ${DOCUMENT_ROOT}
chmod -R 755 ${DOCUMENT_ROOT}

# Створення простої index.html
cat <<EOF > ${DOCUMENT_ROOT}/index.html
<html>
<head>
    <title>Terraform Lab3</title>
</head>
<body>
    <h1>Welcome to ${SERVER_NAME}</h1>
    <p>Server deployed with Terraform and bootstrap.sh</p>
</body>
</html>
EOF

# Налаштування VirtualHost
cat <<EOF > /etc/apache2/sites-available/${SERVER_NAME}.conf
<VirtualHost *:${WEB_PORT}>
    ServerAdmin webmaster@localhost
    ServerName ${SERVER_NAME}
    DocumentRoot ${DOCUMENT_ROOT}
    ErrorLog \${APACHE_LOG_DIR}/error.log
    CustomLog \${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
EOF

# Вимкнення дефолтного сайту та активація нового
a2dissite 000-default.conf
a2ensite ${SERVER_NAME}.conf

# Зміна порту Apache
sed -i "s/Listen 80/Listen ${WEB_PORT}/" /etc/apache2/ports.conf

# Додаткові налаштування для запобігання помилки 403 Forbidden
echo "<Directory ${DOCUMENT_ROOT}>
    Options Indexes FollowSymLinks
    AllowOverride None
    Require all granted
</Directory>" > /etc/apache2/conf-available/${SERVER_NAME}-dir.conf
a2enconf ${SERVER_NAME}-dir.conf

# Перезапуск Apache для застосування змін
systemctl restart apache2
systemctl enable apache2