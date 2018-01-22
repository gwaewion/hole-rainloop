FROM alpine:latest
LABEL maintainer="gwaewion@gmail.com"
EXPOSE 80
VOLUME /rainloop

RUN apk update
RUN apk add nginx php7 php7-fpm php7-session php7-mbstring php7-curl php7-iconv php7-json php7-dom php7-zlib curl
RUN mkdir /run/nginx
RUN chown nginx:nginx /run/nginx
RUN rm -fr /var/www/localhost
WORKDIR /var/www
RUN curl -sL https://repository.rainloop.net/installer.php | php
RUN rm /etc/nginx/conf.d/default.conf
RUN sed -i "s/user nginx;/daemon off;\n\nuser nginx;/" /etc/nginx/nginx.conf
RUN sed -i "s/post_max_size = 8M/post_max_size = 25M/" /etc/php7/php.ini
RUN sed -i "s/upload_max_filesize = 2M/upload_max_filesize = 25M/" /etc/php7/php.ini
COPY rainloop.conf /etc/nginx/conf.d/
COPY run.sh /root/

CMD ["sh", "/root/run.sh"]