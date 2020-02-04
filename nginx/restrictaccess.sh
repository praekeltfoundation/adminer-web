#!/bin/bash


# Add auth_basic if HTTP_AUTH_LOGIN & HTTP_AUTH_PASSWORD
if [ "${HTTP_AUTH_LOGIN}" != "" -a "${HTTP_AUTH_PASSWORD}" != ""  ]; then
  sed -i "s/#auth_basic/auth_basic/g;" /etc/nginx/conf.d/adminer.conf
  rm -rf /etc/nginx/.htpasswd
  echo -n $HTTP_AUTH_LOGIN:$(openssl passwd -apr1 $HTTP_AUTH_PASSWORD) >> /etc/nginx/conf.d/.htpasswd
  echo "Basic auth is on for user ${HTTP_AUTH_LOGIN}..."
else
  echo "Basic auth is off (HTTP_AUTH_PASSWORD not provided)"
fi


# Add allowed ip address if HTTP_AUTH_IP
if [ "${HTTP_AUTH_IP}" != "" ];then
  sed -i "s/#allow ip/allow ${HTTP_AUTH_IP}/g;" /etc/nginx/conf.d/adminer.conf
  sed -i "s/#deny all/deny all/g;" /etc/nginx/conf.d/adminer.conf
  echo "deny all; allow ${HTTP_AUTH_IP}"
fi

# update server name
if [ "${ALLOWED_HOST}" != "" ];then
  sed -i "s/server_name adminer;/server_name ${ALLOWED_HOST}/g;" /etc/nginx/conf.d/adminer.conf
  echo "set server_name  ${ALLOWED_HOST}"
fi
