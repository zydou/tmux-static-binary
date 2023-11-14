ARG LIBEVENT_VERSION
FROM ghcr.io/zydou/tmux-static-binary:libevent-${LIBEVENT_VERSION}

ARG NCURSES_VERSION
ARG CC="/app/bin/musl-gcc -static"
ARG REALCC="cc"
ARG CPPFLAGS="-P"
ENV HOME=/app
WORKDIR /app

RUN mkdir -p "${HOME}/src" && \
    cd "${HOME}/src"  && \
    curl -sSLfk -o ncurses.tar.gz "https://github.com/mirror/ncurses/archive/${NCURSES_VERSION}.tar.gz"  && \
    tar --strip-components 1 -xzf ncurses.tar.gz  && \
    ./configure --prefix="${HOME}" --includedir="${HOME}/include" --libdir="${HOME}/lib" --enable-pc-files --with-pkg-config="${HOME}/lib/pkgconfig" --with-pkg-config-libdir="${HOME}/lib/pkgconfig" --without-ada --without-tests --without-manpages --with-ticlib --with-termlib --with-default-terminfo-dir=/usr/share/terminfo --with-terminfo-dirs=/etc/terminfo:/lib/terminfo:/usr/share/terminfo  && \
    make  && \
    make install  && \
    cd "${HOME}"  && \
    rm -rf "${HOME}/src"
