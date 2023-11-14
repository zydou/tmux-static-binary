FROM buildpack-deps:xenial AS musl

ARG MUSL_VERSION
ARG CC=cc
ARG REALCC=cc
ARG CPPFLAGS="-P"
ENV HOME=/app
WORKDIR /app

RUN mkdir -p "${HOME}/src" && \
    cd "${HOME}/src" && \
    curl -sSLfk -o "musl-${MUSL_VERSION}.tar.gz" "https://github.com/bminor/musl/archive/${MUSL_VERSION}.tar.gz" && \
    tar --strip-components 1 -xzf "musl-${MUSL_VERSION}.tar.gz" && \
    ./configure --enable-gcc-wrapper --disable-shared --prefix="${HOME}" --bindir="${HOME}/bin"     --includedir="${HOME}/include" --libdir="${HOME}/lib" && \
    make && \
    make install && \
    cd "${HOME}" && \
    rm -rf "${HOME}/src"
