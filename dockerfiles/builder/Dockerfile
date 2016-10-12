FROM elixir:1.3

ENV THRIFT_VERSION 0.9.3
ENV THRIFT_DOWNLOAD_MD5 88d667a8ae870d5adeca8cb7d6795442

RUN set -ex \
        \
        && buildDeps=' \
                automake \
                build-essential \
                bison \
                flex \
                g++ \
                git \
                libboost1.55-all-dev \
                libevent-dev \
                libssl-dev \
                libtool \
                pkg-config \
        ' \
        && apt-get update \
        && apt-get install -y --no-install-recommends $buildDeps \
        && rm -rf /var/lib/apt/lists/* \
        \
        && wget -O thrift.tar.gz http://apache-mirror.rbc.ru/pub/apache/thrift/$THRIFT_VERSION/thrift-$THRIFT_VERSION.tar.gz \
        && echo "$THRIFT_DOWNLOAD_MD5 *thrift.tar.gz" | md5sum -c - \
        \
        && mkdir -p /usr/src/thrift \
        && tar -xzf thrift.tar.gz -C /usr/src/thrift --strip-components=1 \
        && rm thrift.tar.gz \
        \
        && cd /usr/src/thrift \
        \
        && ./configure --without-qt4 --without-qt5 --without-csharp --without-java --without-nodejs \
                       --without-lua --without-python --without-perl --without-php --without-php_extension \
                       --without-ruby --without-haskell --without-go --without-haxe --without-d \
        && make -j"$(nproc)" \
        && make check \
        && make install \
        \
        && cd / \
        && rm -r /usr/src/thrift

CMD [ "thrift" ]
