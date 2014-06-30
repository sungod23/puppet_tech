#!/bin/bash

#Check for installed package, and install if missing, remove old index page and replace with one from repository
if ! yum --quiet list installed  nginx  ;
        then
          yum --quiet -y install nginx
          rm -f /usr/share/nginx/html/index.html
          wget -qP /usr/share/nginx/html/ https://raw.githubusercontent.com/puppetlabs/exercise-webpage/master/index.html
fi


#Check for port 8080, replace with port 8080 for default server
a=$(grep default_server /etc/nginx/conf.d/default.conf)
b="    listen   8080 default_server;"
if [ "$a" != "$b" ]; then
sed -i "s/$a/$b/" /etc/nginx/conf.d/default.conf
service nginx restart
fi
