ARG NCURSES_VERSION
FROM ghcr.io/zydou/tmux-static-binary:ncurses-${NCURSES_VERSION} AS build

ARG TMUX_VERSION=381c00a74ea1eb136a97c86da9a7713190b10a62
ARG CC="/app/bin/musl-gcc -static"
ARG REALCC="cc"
ARG CPPFLAGS="-P"
ENV HOME=/app
WORKDIR /app

RUN apt-get update && \
    apt-get install -y --no-install-recommends bison  && \
    mkdir -p "${HOME}/src" && \
    cd "${HOME}/src" && \
    curl -sSLfk -o "tmux-${TMUX_VERSION}.tar.gz" "https://github.com/tmux/tmux/archive/${TMUX_VERSION}.tar.gz" && \
    tar --strip-components 1 -xzf "tmux-${TMUX_VERSION}.tar.gz" && \
    ./autogen.sh && \
    ./configure --prefix="${HOME}" --enable-static --includedir="${HOME}/include" --libdir="${HOME}/lib" CFLAGS="-I${HOME}/include" LDFLAGS="-L${HOME}/lib" CPPFLAGS="-I${HOME}/include" LIBEVENT_LIBS="-L${HOME}/lib -levent" LIBNCURSES_CFLAGS="-I${HOME}/include/ncurses" LIBNCURSES_LIBS="-L${HOME}/lib -lncurses" LIBTINFO_CFLAGS="-I${HOME}/include/ncurses" LIBTINFO_LIBS="-L${HOME}/lib -ltinfo" && \
    make && \
    make install && \
    strip "${HOME}/bin/tmux" && \
    cd "${HOME}" && \
    rm -rf "${HOME}/src"

FROM scratch
COPY --from=build /app/bin/tmux /tmux
