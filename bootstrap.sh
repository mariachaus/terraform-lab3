#!/bin/bash

web_port=${web_port}
document_root=${document_root}
server_name=${server_name}

apt-get update -y
apt-get upgrade -y

apt-get install -y apache2


mkdir -p ${document_root}
chown -R www-data:www-data ${document_root}
chmod -R 755 ${document_root}


cat <<EOF > ${document_root}/index.html
<html>
<head>
    <title>Terraform Lab3</title>
</head>
<body>
    <h1>Welcome to ${server_name}</h1>
    <p>Chaus Mariia, OI-43</p>
    <p>Server deployed with Terraform and bootstrap.sh</p>
</body>
</html>
EOF


cat <<EOF > /etc/apache2/sites-available/${server_name}.conf
<VirtualHost *:${web_port}>
    ServerAdmin webmaster@localhost
    ServerName ${server_name}
    DocumentRoot ${document_root}
    ErrorLog /var/log/apache2/error.log
    CustomLog /var/log/apache2/access.log combined
</VirtualHost>
EOF

a2dissite 000-default.conf
a2ensite ${server_name}.conf


sed -i "s/Listen 80/Listen ${web_port}/" /etc/apache2/ports.conf


echo "<Directory ${document_root}>
    Options Indexes FollowSymLinks
    AllowOverride None
    Require all granted
</Directory>" > /etc/apache2/conf-available/${server_name}-dir.conf
a2enconf ${server_name}-dir.conf


systemctl restart apache2
systemctl enable apache2