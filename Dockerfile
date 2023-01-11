FROM ubuntu:22.04

ENV TZ=Europe/London
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN echo 'APT::Install-Recommends 0;' > /etc/apt/apt.conf.d/01norecommends \
 && echo 'APT::Install-Suggests 0;' >> /etc/apt/apt.conf.d/01norecommends

RUN apt-get update && \
    apt-get install -y -q \
        build-essential \
        ca-certificates \
        libbz2-dev \
        libdb++-dev \
        libexpat-dev \
        libmcpp-dev \
        libssl-dev \
        python3-dev \
        python3-pip \
        wget

RUN mkdir /dist
ADD build.sh /
CMD ["/build.sh"]
