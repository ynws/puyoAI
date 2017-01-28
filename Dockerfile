FROM ubuntu

MAINTAINER ynws

ENV APP_ROOT /home
WORKDIR $APP_ROOT

RUN apt-get update && \
    apt-get install \
                    clang \
                    cmake \
                    git \
                    libffms2-dev \
                    libgflags-dev \
                    libgoogle-glog-dev \
                    libmicrohttpd-dev \
                    libprotobuf-dev \
                    libsdl2-dev \
                    libsdl2-image-dev \
                    libsdl2-ttf-dev \
                    libusb-1.0-0-dev \
                    ninja-build \
                    -y && \
    rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/puyoai/puyoai && \
    cd puyoai && \
    git submodule init && \
    git submodule update

ENV APP_ROOT /home/puyoai
WORKDIR $APP_ROOT

RUN mkdir -p out/Default && \
    cd out/Default && \
    cmake ../../src && \
    make -j8 && \
    make test

CMD ["/bin/bash"]
