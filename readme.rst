Adminer-web
===========

`ALLOWED_HOST` is the domain the server will listen on 

Optional ENV variables to enforce auth_basic to "Restricted"


auth_basic:
  `HTTP_AUTH_LOGIN`
  
  `HTTP_AUTH_PASSWORD` 
  
  When both set the server will require enforce auth_basic to "Restricted"



IP restrictions:
  `HTTP_AUTH_IP`
  
  When this variable is set the server will deny access and exempt HTTP_AUTH_IP
