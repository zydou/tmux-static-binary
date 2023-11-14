ARG MUSL_VERSION
FROM ghcr.io/zydou/tmux-static-binary:musl-${MUSL_VERSION}

ARG LIBEVENT_VERSION
ARG CC="/app/bin/musl-gcc -static"
ARG REALCC="cc"
ARG CPPFLAGS="-P"
ENV HOME=/app
WORKDIR /app

RUN mkdir -p "${HOME}/src" && \
    cd "${HOME}/src" && \
    curl -sSLfk -o "libevent-${LIBEVENT_VERSION}.tar.gz" "https://github.com/libevent/libevent/archive/${LIBEVENT_VERSION}.tar.gz" && \
    tar --strip-components 1 -xzf "libevent-${LIBEVENT_VERSION}.tar.gz" && \
    ./autogen.sh && \
    ./configure --prefix="${HOME}" --includedir="${HOME}/include" --libdir="${HOME}/lib" --disable-shared --disable-openssl --disable-libevent-regress --disable-samples && \
    make && \
    make install && \
    cd "${HOME}" && \
    rm -rf "${HOME}/src"
