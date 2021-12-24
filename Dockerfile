FROM ubuntu:impish AS builder

ARG ARCH=x86_64

COPY /mingw-w64-build /tmp/mingw-w64-build

RUN apt-get update
    apt-get --no-install-recommends -y install build-essential git bison m4 bzip2 curl texinfo flex && \
    apt-get clean && apt-get autoclean && apt-get autoremove && \
    /tmp/mingw-w64-build -p /usr/local $ARCH

FROM ubuntu:impish

COPY --from=builder /usr/local /usr/local
