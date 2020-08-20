FROM alpine:3.12

ADD conf /conf
ADD entrypoint.sh /entrypoint.sh
RUN apk add --update bash nano tzdata mpd icecast ncmpc supervisor nginx php7-fpm ca-certificates php7-pdo_mysql php7-mysqli php7-pdo php7-imagick php7-opcache php7-gd php7-session php7-mcrypt php7-ctype php7-xmlreader php7-xml php7-json php7-curl php7-phar php7-bcmath php7-dom php7-intl php7-pdo_sqlite php7-mbstring php7-zip php7-xmlwriter php7-iconv php7-simplexml php7-posix php7-pcntl \
&& cp /usr/share/zoneinfo/Europe/Moscow /etc/localtime \
&& echo "Europe/Moscow" > /etc/timezone \
&& apk del tzdata \
&& mkdir -p /etc/supervisor.d \
&& chmod 755 /entrypoint.sh \
&& mkdir -p /etc/default \
&& mv /etc/nginx /etc/default/nginx \
&& mv /etc/php7 /etc/default/php7 \
&& mkdir -p /etc/default/nginx/default.d \
&& mkdir /run/nginx \
&& mkdir /run/php-fpm
ADD conf/supervisor/radio.ini /etc/supervisor.d/radio.ini
ADD conf/supervisor/icecast.ini /etc/supervisor.d/icecast.ini
ADD conf/supervisor/nginx.ini /etc/supervisor.d/nginx.ini
ADD conf/supervisor/php-fpm.ini /etc/supervisor.d/php-fpm.ini
ADD conf/vhosts /etc/default/nginx/vhosts.a/
ADD conf/nginx/nginx.conf /etc/default/nginx/nginx.conf
ADD conf/nginx/php-fpm.conf /etc/default/nginx/conf.d/php-fpm.conf
ADD conf/nginx/php.conf /etc/default/nginx/default.d/php.conf
ADD conf/php/php.ini /etc/default/php7/php.ini
ADD conf/php/www.conf /etc/default/php7/php-fpm.d/www.conf

VOLUME ["/var/lib/mpd", "/var/log/mpd", "/var/log/icecast"]
CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisord.conf"]
ENTRYPOINT ["/entrypoint.sh"]
