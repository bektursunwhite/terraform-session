#!/bin/bash

sudo dnf update -y
sudo dnf install -y httpd
sudo systemctl start httpd
sudo systemctl enable httpd

cat <<EOF > /var/www/html/index.html
<html>
  <body>
    <h1> Instance is running! </h1>
    <p>Public IP of ${environment} instance: $</p>
  </body>
</html>
EOF

# $environment = var.env
