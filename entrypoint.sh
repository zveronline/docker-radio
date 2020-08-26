#!/bin/bash
set -e

if [ ! -d /var/lib/mpd/playlists ]
then
mkdir /var/lib/mpd/playlists
fi

sed -i s/ADMIN_PASSWORD/$ADMIN_PASSWORD/g /conf/icecast.xml

exec "$@"
