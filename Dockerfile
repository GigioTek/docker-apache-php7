FROM debian:jessie

RUN apt-get update && apt-get install -y \
		ca-certificates \
		curl \
		vim \
		wget \
		apache2 \
	    --no-install-recommends && rm -r /var/lib/apt/lists/*
RUN echo "deb http://packages.dotdeb.org jessie all" > /etc/apt/sources.list.d/dotdeb.list && \
        wget https://www.dotdeb.org/dotdeb.gpg && \
        apt-key add dotdeb.gpg

RUN apt-get update && apt-get install -y \
        php7.0 \
        libapache2-mod-php7.0 \
        php7.0-gd \
        php7.0-mysql \
        php7.0-bz2 \
        php7.0-json \
        php7.0-curl \
        --no-install-recommends && rm -r /var/lib/apt/lists/*
#ADD config/php/30-custom_php.ini /usr/local/etc/php/conf.d/30-custom_php.ini
ADD conf/apache/testapp.conf /etc/apache2/sites-enabled/testapp.conf

    # Apache + PHP requires preforking Apache for best results
#    a2dismod mpm_event \
#    a2enmod mpm_prefork \
#    service apache2 restart

VOLUME /var/www
WORKDIR /var/www

EXPOSE 80