#!/bin/bash
set -e

if [ ! -d /var/lib/mpd/playlists ]
then
mkdir /var/lib/mpd/playlists
fi

exec "$@"
