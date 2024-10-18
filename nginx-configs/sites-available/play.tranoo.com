##
# You should look at the following URL's in order to grasp a solid understanding
# of Nginx configuration files in order to fully unleash the power of Nginx.
# https://www.nginx.com/resources/wiki/start/
# https://www.nginx.com/resources/wiki/start/topics/tutorials/config_pitfalls/
# https://wiki.debian.org/Nginx/DirectoryStructure
#
# In most cases, administrators will remove this file from sites-enabled/ and
# leave it as reference inside of sites-available where it will continue to be
# updated by the nginx packaging team.
#
# This file will automatically load configuration files provided by other
# applications, such as Drupal or Wordpress. These applications will be made
# available underneath a path with that package name, such as /drupal8.
#
# Please see /usr/share/doc/nginx-doc/examples/ for more detailed examples.
##

server {
	#tranoo-3d-js server
	# SSL configuration
	#
	listen 443 ssl;
	listen [::]:443 ssl;
	#
	# Note: You should disable gzip for SSL traffic.
	# See: https://bugs.debian.org/773332
	#
	# Read up on ssl_ciphers to ensure a secure configuration.
	# See: https://bugs.debian.org/765782
	#
	# Self signed certs generated by the ssl-cert package
	# Don't use them in a production server!
	#
#	include snippets/snakeoil.conf;
#ssl_certificate /etc/letsencrypt/live/tranoo.com/cert.pem;
#/etc/ssl/certs/ssl-cert-snakeoil.pem;
#ssl_certificate_key /etc/letsencrypt/live/tranoo.com/privkey.pem;
#/etc/ssl/private/ssl-cert-snakeoil.key;


	#root /root/rig1_public_html_root;
	root /zsata/play-tranoo-com-public_html;

	# Add index.php to the list if you are using PHP
	index index.html index.htm index.nginx-debian.html index.php;

	server_name play.tranoo.com;

        location / {
               proxy_set_header   X-Forwarded-For $remote_addr;
               proxy_set_header   Host $http_host;
               proxy_pass         http://127.0.0.1:3000;
	       proxy_http_version 1.1;
       	       proxy_set_header Upgrade $http_upgrade;
               proxy_set_header Connection "upgrade";
               proxy_read_timeout 86400;
        }

	# pass PHP scripts to FastCGI server
	#
	#location ~ \.php$ {
	#	include snippets/fastcgi-php.conf;
	#
	#	# With php-fpm (or other unix sockets):
	#	fastcgi_pass unix:/var/run/php/php7.4-fpm.sock;
	#	# With php-cgi (or other tcp sockets):
	#	# fastcgi_pass 127.0.0.1:9000;
	#}

	# deny access to .htaccess files, if Apache's document root
	# concurs with nginx's one
	
	location ~ /\.ht {
		deny all;
	}

    ssl_certificate /etc/letsencrypt/live/swap.tranoo.com-0001/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/swap.tranoo.com-0001/privkey.pem; # managed by Certbot
}

#server {
#	#lcs-reflector
#	# SSL configuration
#	#
#	listen 3001 ssl;
#	listen [::]:3001 ssl;
	#
	# Note: You should disable gzip for SSL traffic.
	# See: https://bugs.debian.org/773332
	#
	# Read up on ssl_ciphers to ensure a secure configuration.
	# See: https://bugs.debian.org/765782
	#
	# Self signed certs generated by the ssl-cert package
	# Don't use them in a production server!
	#
#	include snippets/snakeoil.conf;
#ssl_certificate /etc/letsencrypt/live/tranoo.com/cert.pem;
#/etc/ssl/certs/ssl-cert-snakeoil.pem;
#ssl_certificate_key /etc/letsencrypt/live/tranoo.com/privkey.pem;
#/etc/ssl/private/ssl-cert-snakeoil.key;


	#root /root/rig1_public_html_root;
#	root /zsata/play-tranoo-com-public_html;

	# Add index.php to the list if you are using PHP
#	index index.html index.htm index.nginx-debian.html index.php;

#	server_name play.tranoo.com;

#        location / {
#               proxy_set_header   X-Forwarded-For $remote_addr;
#               proxy_set_header   Host $http_host;
#               proxy_pass         http://127.0.0.1:3000;
#        }

	# pass PHP scripts to FastCGI server
	#
	#location ~ \.php$ {
	#	include snippets/fastcgi-php.conf;
	#
	#	# With php-fpm (or other unix sockets):
	#	fastcgi_pass unix:/var/run/php/php7.4-fpm.sock;
	#	# With php-cgi (or other tcp sockets):
	#	# fastcgi_pass 127.0.0.1:9000;
	#}

	# deny access to .htaccess files, if Apache's document root
	# concurs with nginx's one
	
#	location ~ /\.ht {
#		deny all;
#	}

#    ssl_certificate /etc/letsencrypt/live/tranoo.com/fullchain.pem; # managed by Certbot
#    ssl_certificate_key /etc/letsencrypt/live/tranoo.com/privkey.pem; # managed by Certbot
#}


# Virtual Host configuration for example.com
#
# You can move that to a different file under sites-available/ and symlink that
# to sites-enabled/ to enable it.
#
#server {
#	listen 80;
#	listen [::]:80;
#
#	server_name example.com;
#
#	root /var/www/example.com;
#	index index.html;
#
#	location / {
#		try_files $uri $uri/ =404;
#	}
#}