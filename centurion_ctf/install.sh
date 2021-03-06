#!/bin/bash
#Check if we're root
if [[ $(whoami) != "root" ]]; then
	echo "Must be root!"
	exit
fi

#Copy WebApp
cp ./WebApp/CTF.html /var/www/html/CTF.html
cp ./WebApp/CTF.php /var/www/html/php/CTF.php
cp ./WebApp/cent.ctf.js /var/www/html/js/cent.ctf.js
#Make Source Code, Flag and Challenge directories
mkdir /opt/source/
mkdir /opt/flags/
mkdir /opt/challenges/
chown www-data.www-data /opt/source
chown www-data.www-data /opt/flags
chown www-data.www-data /opt/challenges
#Copy Challenge Generation Scripts into /usr/bin
cp ./CTF_Scripts/local /usr/bin/local-ctf
cp ./CTF_Scripts/network /usr/bin/network-ctf
cp ./CTF_Scripts/web /usr/bin/web-ctf
chown root.root /usr/bin/local-ctf
chown root.root /usr/bin/network-ctf
chmod 755 /usr/bin/local-ctf
chmod 755 /usr/bin/network-ctf
#Add sudoers file
chown root.root ./config/012_www-data-ctf
cp ./config/012_www-data-ctf /etc/sudoers.d/012_www-data-ctf
#Create ctf users
echo "Adding CTF users...you will be prompted to create passwords for them!"
adduser ctf1
adduser ctf2
#Add necessary packages
apt-get install gcc
apt-get install g++
apt-get install make
apt-get install libapache2-mpm-itk
apt-get install zip
#Setup Challenge Web Server
cp ./config/001-challenge.conf /etc/apache2/sites-available/
mkdir /opt/challenges/web
chown ctf1.ctf1 /opt/challenges/web
chmod 744 /opt/challenges/web
#Setup Live Mode
mkdir /etc/ctf-live
echo "0" > /etc/ctf-live/live-mode
cp ./CTF_Scripts/live /usr/bin/live-ctf
