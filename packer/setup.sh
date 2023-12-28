#!/bin/bash

systemctl restart sshd.service
yum install httpd php -y

systemctl restart httpd.service php-fpm.service
systemctl enable httpd.service php-fpm.service
