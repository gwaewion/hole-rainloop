#!/bin/sh

if [ -f /rainloop/index.php ]
then
	php-fpm7
	nginx
else
	cp -R /var/www/* /rainloop/
	find /rainloop -type d -exec chmod 755 {} \;
	find /rainloop -type f -exec chmod 644 {} \;
	chown -R nginx:nginx /rainloop
	chmod 777 /rainloop/data

	php-fpm7
	nginx
fi