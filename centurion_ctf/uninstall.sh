#!/bin/bash
#Check if we're root
if [[ $(whoami) != "root" ]]; then
	echo "Must be root!"
	exit
fi

#Copy WebApp
rm /var/www/html/CTF.html
rm /var/www/html/php/CTF.php
rm /var/www/html/js/cent.ctf.js
