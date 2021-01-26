FROM alpine:3.13

ENV ROMPR_VERSION=1.48 \
ADMIN_PASSWORD=qwe123test \
HOSTNAME=localhost \
NAMESTREAM=radio \
DESCRIPTION=radio \
BITRATE=256 \
ENCODER=ogg \
MOUNT=radio.ogg \
ICECAST_HOST=127.0.0.1 \
ICECAST_PASSWORD=qwe123

ADD conf /conf
ADD entrypoint.sh /entrypoint.sh
ADD https://github.com/fatg3erman/RompR/releases/download/${ROMPR_VERSION}/rompr-${ROMPR_VERSION}.zip /tmp/rompr.zip
RUN apk add --update wget unzip bash nano tzdata mpd icecast ncmpc supervisor nginx php7-fpm php7-sqlite3 php7-pdo_mysql php7-mysqli php7-pdo php7-openssl php7-imagick php7-opcache php7-gd php7-session php7-mcrypt php7-ctype php7-xmlreader php7-xml php7-json php7-curl php7-phar php7-bcmath php7-dom php7-intl php7-pdo_sqlite php7-mbstring php7-zip php7-xmlwriter php7-iconv php7-simplexml php7-posix php7-pcntl php7-fileinfo php7-apcu php7-tokenizer diffutils composer logrotate \
&& cp /usr/share/zoneinfo/Europe/Moscow /etc/localtime \
&& echo "Europe/Moscow" > /etc/timezone \
&& apk del tzdata \
&& mkdir -p /etc/supervisor.d \
&& chmod 755 /entrypoint.sh \
&& mkdir -p /etc/nginx/default.d \
&& mkdir /run/nginx \
&& mkdir /run/php-fpm \
&& cd /tmp \
&& unzip rompr.zip \
&& mv rompr /srv/ \
&& rm -f rompr.zip \
&& ln -sf /conf/supervisor/radio.ini /etc/supervisor.d/radio.ini \
&& ln -sf /conf/supervisor/icecast.ini /etc/supervisor.d/icecast.ini \
&& ln -sf /conf/supervisor/nginx.ini /etc/supervisor.d/nginx.ini \
&& ln -sf /conf/supervisor/php-fpm.ini /etc/supervisor.d/php-fpm.ini \
&& ln -sf /conf/vhosts /etc/nginx/vhosts.d \
&& ln -sf /conf/nginx/nginx.conf /etc/nginx/nginx.conf \
&& ln -sf /conf/nginx/php-fpm.conf /etc/nginx/conf.d/php-fpm.conf \
&& ln -sf /conf/nginx/php.conf /etc/nginx/default.d/php.conf \
&& ln -sf /conf/php/php.ini /etc/php7/php.ini \
&& ln -sf /conf/php/www.conf /etc/php7/php-fpm.d/www.conf \
&& chown -R nginx:nginx /etc/php7 \
&& chown -R nginx:nginx /etc/nginx \
&& chown root:root /usr/bin/mpd \
&& rm -f /etc/nginx/conf.d/default.conf \
&& mkdir -p /srv/rompr/prefs \
&& chown -R nginx:nginx /srv

VOLUME ["/var/lib/mpd", "/srv/rompr/prefs", "/srv/rompr/albumart"]
CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisord.conf"]
ENTRYPOINT ["/entrypoint.sh"]
