#!/bin/bash
apt update -y
apt install -y nginx

INSTANCE_NAME="Server-${server_index}"
PRIVATE_IP=$(hostname -I | awk '{print $1}')
WEB_DIR="/var/www/html"

# Create main index page
cat <<HTML > $WEB_DIR/index.html
<html>
<head><title>Abhi Private Servers</title></head>
<body style='font-family:Arial;text-align:center;margin-top:80px;'>
<h1>Welcome to Abhi's Private Network</h1>
<p>This server hosts multiple pages for testing load balancing.</p>
<h3>Available Pages:</h3>
<ul>
  <li><a href='/server${server_index}.html'>Server ${server_index}</a></li>
</ul>
</body></html>
HTML

# Create dedicated server page
cat <<HTML > $WEB_DIR/server${server_index}.html
<html>
<head><title>$INSTANCE_NAME</title></head>
<body style='font-family:Arial;text-align:center;margin-top:100px;'>
<h1>$INSTANCE_NAME</h1>
<h2>Private IP: $PRIVATE_IP</h2>
<p>This is a unique page for $INSTANCE_NAME (behind the ALB).</p>
<p>Served from folder: $WEB_DIR</p>
</body></html>
HTML

systemctl enable nginx
systemctl start nginx
