#!/bin/bash
./configure \
	--prefix=/ \
	--sbin-path=/usr/sbin/ \
	--conf-path=/etc/nginx/nginx.conf \
	--with-cc-opt='-g -O2 -fPIE -fstack-protector --param=ssp-buffer-size=4 -Wformat -Werror=format-security -D_FORTIFY_SOURCE=2' --with-ld-opt='-Wl,-Bsymbolic-functions -fPIE -pie -Wl,-z,relro -Wl,-z,now' \
	--http-log-path=/var/log/nginx/access.log  \
	--error-log-path=/var/log/nginx/error.log \
	--http-fastcgi-temp-path=/var/lib/nginx/fastcgi \
	--with-http_gzip_static_module \
	--with-http_stub_status_module \
	--with-http_ssl_module \
	##### need to resolve this???--with-openssl=/root/build/openssl-1.0.2h \
	--with-http_v2_module \
        --with-http_gzip_static_module \
        ## added below with 03 --with-cc-opt \
        --with-cc-opt="-O3" \
        --without-mail_pop3_module \
        --without-mail_imap_module \
        --without-mail_smtp_module \
	--with-http_realip_module \
	--with-http_addition_module \
	--with-http_sub_module \
	--with-http_dav_module \
	--with-http_flv_module \
	--with-http_mp4_module \
	--with-http_gunzip_module \
	--with-http_gzip_static_module \
	--with-http_random_index_module \
	--with-http_secure_link_module \
	--with-http_stub_status_module \
	--with-http_auth_request_module \
	--with-file-aio \
	--with-ipv6 \
	--with-threads \
	--with-stream \
	--with-stream_ssl_module \
	--add-module=../ngx_pagespeed-release-1.11.33.2-beta \
        --add-module=../ngx_brotli \
        --add-module=../ngx_cache_purge \
        --add-module=../headers-more-nginx-module \
        --add-module=../nginx-vod-module \
       
#        --with-cpu-opt=pentium4 \

