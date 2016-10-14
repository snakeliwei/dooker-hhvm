FROM debian:jessie
MAINTAINER Lyndon li <snakeliwei@gmail.com>

ENV S6_OVERLAY_VERSION 1.18.1.5

# Add s6-overlay
ADD https://github.com/just-containers/s6-overlay/releases/download/v$S6_OVERLAY_VERSION/s6-overlay-amd64.tar.gz /tmp/
RUN tar xzf /tmp/s6-overlay-amd64.tar.gz -C / && \
    rm /tmp/s6-overlay-amd64.tar.gz

RUN apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0x5a16e7281be7a449 && \
    echo deb http://dl.hhvm.com/debian jessie main | sudo tee /etc/apt/sources.list.d/hhvm.list && \
    apt-get update  && \
    apt-get install -qy git hhvm curl vim && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/init"]
