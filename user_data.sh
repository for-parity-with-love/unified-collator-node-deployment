#!/bin/bash

sudo apt install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm -y

sudo apt update -y
sudo apt upgrade -y
sudo apt install curl htop nano wget -y
sudo wget https://raw.githubusercontent.com/serverok/squid-proxy-installer/master/squid3-install.sh
sudo bash squid3-install.sh

sudo sed -i "s@http_port 3128@http_port 3333@g" /etc/squid/squid.conf

touch /etc/squid/passwd
echo "devchilasaluser:\$apr1\$KyB5VuF5\$Fj6NcfCWLg5BR0fFa7SCs/
prodschilasaser:\$apr1\$JJOaDsee\$de7mtPna.ecqUcm4nx4un0/
testdfjnf2ss:\$apr1\$Cuvd/VPL\$CaHDgDHSdZig5Lw40S2vO1" > /etc/squid/passwd

sudo systemctl restart squid

# decoded passwords are here: https://docs.google.com/spreadsheets/d/1TcFnB0dVlCBS_VYm6vDK8OKoAvx9sY5UuUAuoQI9Th8/edit#gid=422672063
