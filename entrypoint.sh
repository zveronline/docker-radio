#!/bin/bash
set -e

if [ ! -d /var/lib/mpd/playlists ]
then
mkdir /var/lib/mpd/playlists
fi

sed -i s/ADMIN_PASSWORD/$ADMIN_PASSWORD/g /conf/icecast.xml
sed -i s/BITRATE/$BITRATE/g /conf/radio.conf
sed -i s/ENCODER/$ENCODER/g /conf/radio.conf
sed -i s/MOUNT/$MOUNT/g /conf/radio.conf

exec "$@"
