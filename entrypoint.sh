#!/bin/bash
set -e

if [ ! -d /var/lib/mpd/playlists ]
then
mkdir /var/lib/mpd/playlists
fi

sed -i s/ADMIN_PASSWORD/$ADMIN_PASSWORD/g /conf/icecast.xml
sed -i s/NAMESTREAM/$NAMESTREAM/g /conf/radio.conf
sed -i s/DESCRIPTION/$DESCRIPTION/g /conf/radio.conf
sed -i s/BITRATE/$BITRATE/g /conf/radio.conf
sed -i s/ENCODER/$ENCODER/g /conf/radio.conf
sed -i s/MOUNT/$MOUNT/g /conf/radio.conf
sed -i s/ICECAST_HOST/$ICECAST_HOST/g /conf/radio.conf
sed -i s/ICECAST_PASSWORD/$ICECAST_PASSWORD/g /conf/radio.conf

if [ ! $ICECAST_HOST == 127.0.0.1 ]
then
rm -f /etc/supervisor.d/icecast.ini
fi
exec "$@"
