FROM ubuntu:impish AS builder

ARG ARCH=x86_64

COPY /mingw-w64-build /tmp/mingw-w64-build

RUN apt-get update && \
    apt-get -y install build-essential git bison m4 bzip2 curl texinfo flex && \
    apt-get clean && apt-get autoclean && apt-get autoremove

RUN /tmp/mingw-w64-build -p /usr/local $ARCH

FROM ubuntu:impish

COPY --from=builder /usr/local/ /usr/local/

RUN apt-get update && \
    apt-get -y install make && \
    update-alternatives --install /usr/bin/gcc gcc /usr/local/bin/x86_64-w64-mingw32-gcc 20 && \
    update-alternatives --install /usr/bin/g++ g++ /usr/local/bin/x86_64-w64-mingw32-g++c 20
