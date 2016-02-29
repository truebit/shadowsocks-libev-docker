FROM ubuntu:14.04.4
MAINTAINER Xiao Wang (wangxiao8611@gmail.com)
USER root
ENV DEPENDENCIES build-essential autoconf libtool libssl-dev git-core ca-certificates
ENV BASEDIR /tmp/shadowsocks-libev

# build shadowsocks-libev from scratch
RUN apt-get update && \
    apt-get install --no-install-recommends -y $DEPENDENCIES && \
    rm -rf /var/lib/apt/lists/*
RUN git clone https://github.com/shadowsocks/shadowsocks-libev.git $BASEDIR
WORKDIR $BASEDIR
RUN ./configure && \ 
    make && \
    make install 
# clean up 
WORKDIR /
RUN rm -rf $BASEDIR/shadowsocks-libev \
    && apt-get --purge autoremove -y $DEPENDENCIES
#output encoding
#RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
#    sed -i -e 's/# zh_CN.UTF-8 UTF-8/zh_CN.UTF-8 UTF-8/' /etc/locale.gen && \
#    dpkg-reconfigure --frontend=noninteractive locales
#ENV LANG zh_CN.UTF-8
#ENV LANGUAGE zh_CN:zh
#ENV LC_ALL zh_CN.UTF-8
ENTRYPOINT [ "ss-server" ]
