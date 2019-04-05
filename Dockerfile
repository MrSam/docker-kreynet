FROM ubuntu:16.04 AS build
MAINTAINER Sam Hermans <sam.hermans@gmail.com> 

ENV VANTAGE_VERSION vantage-1.3.4

RUN apt-get update && apt-get install -qq -y build-essential wget libssl-dev libssl-doc openssl libgnutls-openssl27 --no-install-recommends 

WORKDIR /vantage

COPY dist/$VANTAGE_VERSION.tar .

RUN tar -xf $VANTAGE_VERSION.tar ; cd $VANTAGE_VERSION ; ./configure --prefix=/vantage --enable-ipv6 --enable-openssl

COPY etc/config.h $VANTAGE_VERSION/x86_64-unknown-linux-gnu/config.h

RUN cd $VANTAGE_VERSION/x86_64-unknown-linux-gnu/ ; make install
RUN rm -rf $VANTAGE_VERSION $VANTAGE_VERSION.tar


FROM ubuntu:16.04
MAINTAINER Sam Hermans <sam.hermans@gmail.com>
COPY --from=build /vantage /vantage
COPY etc/ircd.conf /vantage/etc/ircd.conf
RUN useradd -ms /bin/bash vantage
RUN chown -R vantage /vantage/var
RUN chgrp -R vantage /vantage/sbin; chmod -R 750 /vantage/sbin

USER vantage
WORKDIR vantage
EXPOSE 6667

CMD /vantage/sbin/vantage -t
