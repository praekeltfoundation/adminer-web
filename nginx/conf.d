
limit_req_zone $binary_remote_addr zone=ddos_limit:1m rate=5r/s;

server {
    listen         80;
    server_name	   adminer;

#    allow 192.168.1.1/24;
#    allow 127.0.0.1;
#    deny all;

    root           /var/www/;
    index          index.php;

    include        global/restrictions.conf;

    auth_basic "Restricted";
    auth_basic_user_file /etc/nginx/.htpasswd/admin;

    limit_req_log_level warn;

    access_log     /var/log/nginx/admin.access.log;
    error_log      /var/log/nginx/admin.error.log;

    location / {
        try_files $uri $uri/ =404;
    }

    location ~ /\. {
        deny all;
        access_log off;
        log_not_found off;
    }


    location ~ \.php$ {
        limit_req zone=ddos_limit burst=12 nodelay=8;

        fastcgi_pass unix:/run/php/php7.0-fpm.sock;

    	try_files $uri =404;
    	fastcgi_split_path_info ^(.+\.php)(/.+)$;
    	fastcgi_pass php;
    	fastcgi_index index.php;
    	fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
    	include fastcgi_params;
    }
}
