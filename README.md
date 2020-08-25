# Introduction

Dockerfile to build internet radio container.

# Installation

Pull the latest version of the image from the docker.

```
docker pull zveronline/radio
```

Alternately you can build the image yourself.

```
docker build -t zveronline/radio https://github.com/zveronline/docker-radio.git
```

# Quick Start

Run the image

```
docker run --name radio -d \
   --volume /yourpath/Music:/Music \
   --volume mpd:/var/lib/mpd \
   --volume rompr-db:/srv/rompr/prefs \
   --volume rompr-albumart:/srv/rompr/albumart \
   --publish 8001:80 \
   --publish 8002:8002
   zveronline/radio
```

This will start the container and you should now be able to browse the web interface on port 8001 and icecast on port 8002.
Directory "Music" must contains yor music files.

# Docker-compose template
```
version: '2'
services:
  radio:
    image: zveronline/radio
    container_name: radio
    volumes:
      - /yourpath/Music:/Music
      - mpd:/var/lib/mpd
      - rompr-db:/srv/rompr/prefs
      - rompr-albumart:/srv/rompr/albumart
    ports:
      - "8001:80"
      - "8002:8002"
```
# Rompr screen
![ROMPR](https://zveronline.ru/wp-content/uploads/2020/08/Screenshot_20200825_220508-1024x757.png)
