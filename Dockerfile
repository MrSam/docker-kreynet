FROM ubuntu:16.04
MAINTAINER Sam Hermans <sam.hermans@gmail.com> 

ENV VANTAGE_VERSION vantage-1.3.4

RUN apt-get update && apt-get install -qq -y build-essential wget libssl-dev libssl-doc openssl libgnutls-openssl27 --no-install-recommends 

COPY dist/$VANTAGE_VERSION.tar /vantage/$VANTAGE_VERSION.tar

RUN cd /vantage/ ; tar -xf $VANTAGE_VERSION.tar ; cd $VANTAGE_VERSION ; ./configure --prefix=/vantage --enable-ipv6 --enable-openssl

COPY etc/config.h /vantage/$VANTAGE_VERSION/x86_64-unknown-linux-gnu/config.h

RUN cd /vantage/$VANTAGE_VERSION/x86_64-unknown-linux-gnu/ ; make install

COPY etc/ircd.conf /vantage/etc/ircd.conf 
