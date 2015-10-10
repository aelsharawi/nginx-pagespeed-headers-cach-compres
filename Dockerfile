FROM ubuntu:14.04.3
MAINTAINER Peter Tonoli "dockernginxtra@metaverse.org"
ENV http_proxy 'http://proxy.intra.metaverse.org:3128'
ENV https_proxy 'http://proxy.intra.metaverse.org:3128'
RUN echo 'Acquire::http::Proxy "http://proxy.intra.metaverse.org:3142/";' > /etc/apt/apt.conf.d/proxy
RUN apt-get update && apt-get -y upgrade
RUN apt-get -y install checkinstall \
	libpcre3-dev \
	zlib1g-dev \
	libpcre3 \
	unzip
RUN apt-get clean

ADD http://nginx.org/download/nginx-1.9.0.tar.gz /root/build/
WORKDIR /root/build
RUN tar -xf nginx-1.9.0.tar.gz

ADD https://github.com/pagespeed/ngx_pagespeed/archive/release-1.9.32.10-beta.zip /root/build/
WORKDIR /root/build
RUN unzip release-1.9.32.10-beta.zip
WORKDIR /root/build/ngx_pagespeed-release-1.9.32.10-beta 
#ADD https://dl.google.com/dl/page-speed/psol/1.9.32.10.tar.gz /root/build/ngx_pagespeed-release-1.9.32.10-beta
COPY /1.9.32.10.tar.gz /root/build/ngx_pagespeed-release-1.9.32.10-beta/
WORKDIR /root/build/ngx_pagespeed-release-1.9.32.10-beta
RUN tar -xvzf 1.9.32.10.tar.gz

ADD ./resource/configure.sh /root/build/nginx-1.9.0/
WORKDIR /root/build/nginx-1.9.0
RUN chmod a+x configure.sh
RUN ./configure.sh && make
RUN echo "metaverseorg: Nginx 1.9.0" > description-pak && \
	checkinstall -Dy --install=no --nodoc make -i install

CMD ["/bin/bash"]
