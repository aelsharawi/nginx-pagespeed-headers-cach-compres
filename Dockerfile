FROM ubuntu:14.04.3
MAINTAINER Peter Tonoli "dockernginxtra@metaverse.org"
# Statically compile Brotli at the moment, as the library isn't in the Ubuntu mainline yet
ENV NGX_BROTLI_STATIC_MODULE_ONLY=1
RUN apt-get update && apt-get -y upgrade
RUN apt-get -y install checkinstall \
	libpcre3-dev \
	zlib1g-dev \
	libpcre3 \
	unzip \ 
	git \
	libssl-dev
RUN apt-get clean

ADD http://nginx.org/download/nginx-1.9.13.tar.gz /root/build/
WORKDIR /root/build
RUN tar -xf nginx-1.9.13.tar.gz

ADD https://github.com/pagespeed/ngx_pagespeed/archive/release-1.11.33.0-beta.zip /root/build/
WORKDIR /root/build
RUN unzip release-1.11.33.0-beta.zip
WORKDIR /root/build/ngx_pagespeed-release-1.11.33.0-beta 
ADD https://dl.google.com/dl/page-speed/psol/1.11.33.0.tar.gz /root/build/ngx_pagespeed-release-1.11.33.0-beta/
#COPY /1.11.33.0.tar.gz /root/build/ngx_pagespeed-release-1.11.33.0-beta/
WORKDIR /root/build/ngx_pagespeed-release-1.11.33.0-beta
RUN tar -xvzf 1.11.33.0.tar.gz

WORKDIR /root/build/ngx_brotli
RUN git clone https://github.com/google/ngx_brotli.git /root/build/ngx_brotli/

WORKDIR /root/build/nginx-upstream-fair
RUN git clone https://github.com/gnosek/nginx-upstream-fair.git /root/build/nginx-upstream-fair/


ADD ./resource/configure.sh /root/build/nginx-1.9.13/
WORKDIR /root/build/nginx-1.9.13
RUN chmod a+x configure.sh
RUN ./configure.sh && make -j4
RUN echo "metaverseorg: Nginx 1.9.13" > description-pak && \
	checkinstall --strip --exclude /etc/nginx/* -Dy --install=no --nodoc make -i install

CMD ["/bin/bash"]
