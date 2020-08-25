FROM alpine:3.11

ENV ROMPR_VERSION 1.30

ADD conf /conf
ADD entrypoint.sh /entrypoint.sh
ADD https://github.com/fatg3erman/RompR/releases/download/${ROMPR_VERSION}/rompr-${ROMPR_VERSION}.zip /tmp/rompr.zip
RUN apk add --update wget unzip bash nano tzdata mpd icecast ncmpc supervisor nginx php7-fpm ca-certificates php7-pdo_mysql php7-pdo_pgsql php7-pgsql php7-mysqli php7-pdo php7-openssl php7-imagick php7-opcache php7-gd php7-session php7-mcrypt php7-ctype php7-xmlreader php7-xml php7-json php7-curl php7-phar php7-bcmath php7-dom php7-intl php7-pdo_sqlite php7-mbstring php7-zip php7-xmlwriter php7-iconv php7-simplexml php7-posix php7-pcntl php7-fileinfo php7-apcu php7-tokenizer diffutils composer logrotate \
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
&& rm -f rompr.zip
ADD conf/supervisor/radio.ini /etc/supervisor.d/radio.ini
ADD conf/supervisor/icecast.ini /etc/supervisor.d/icecast.ini
ADD conf/supervisor/nginx.ini /etc/supervisor.d/nginx.ini
ADD conf/supervisor/php-fpm.ini /etc/supervisor.d/php-fpm.ini
ADD conf/vhosts /etc/nginx/vhosts.d/
ADD conf/nginx/nginx.conf /etc/nginx/nginx.conf
ADD conf/nginx/php-fpm.conf /etc/nginx/conf.d/php-fpm.conf
ADD conf/nginx/php.conf /etc/nginx/default.d/php.conf
ADD conf/php/php.ini /etc/php7/php.ini
ADD conf/php/www.conf /etc/php7/php-fpm.d/www.conf
RUN chown -R nginx:nginx /etc/php7 \
&& chown -R nginx:nginx /etc/nginx \
&& chown -R nginx:nginx /srv \
&& rm -f /etc/nginx/conf.d/default.conf

VOLUME ["/var/lib/mpd", "/var/log/mpd", "/var/log/icecast"]
CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisord.conf"]
ENTRYPOINT ["/entrypoint.sh"]
