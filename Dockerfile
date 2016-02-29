FROM ubuntu:14.04.4
MAINTAINER Xiao Wang (wangxiao8611@gmail.com)

RUN apt-get install -y wget
RUN wget -O- http://shadowsocks.org/debian/1D27208A.gpg | sudo apt-key add -
RUN echo 'deb http://shadowsocks.org/debian trusty main' >> /etc/apt/sources.list
RUN apt-get update && apt-get install -y --force-yes shadowsocks-libev

ENTRYPOINT [ "ss-server" ]
