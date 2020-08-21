#!/bin/bash
set -e

if [ ! -d /var/lib/mpd/playlists ]
then
mkdir /var/lib/mpd/playlists
fi

if [ ! -f /etc/nginx/nginx.conf ]
then
  mkdir -p /etc/nginx/vhosts.a
  mkdir -p /etc/nginx/vhosts.d
  mkdir -p /etc/nginx/default.d
  mkdir -p /etc/nginx/ssl
  ln -s /etc/nginx/vhosts.a/default /etc/nginx/vhosts.d/
fi
if [ ! -f /etc/php7/php.ini ]
then
  cp -r /etc/default/php7/* /etc/php7/
  chown -R nginx:nginx /etc/php7
fi
cp -r /etc/default/nginx/* /etc/nginx/
cp -r /etc/default/http /srv/
rm -f /etc/nginx/conf.d/default.conf
chown -R nginx:nginx /etc/nginx

exec "$@"
