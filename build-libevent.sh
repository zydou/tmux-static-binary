#!/bin/sh

export CC="${HOME}/bin/musl-gcc -static"
export REALCC="cc"
export CPPFLAGS="-P"

mkdir -p "${HOME}/src"
cd "${HOME}/src" || exit 1

echo "Downloading libevent-${LIBEVENT_VERSION}"
curl -sSLfk -o "libevent-${LIBEVENT_VERSION}.tar.gz" "https://github.com/libevent/libevent/releases/download/release-${LIBEVENT_VERSION}/libevent-${LIBEVENT_VERSION}.tar.gz"

echo "Extracting libevent-${LIBEVENT_VERSION}"
tar -xzf "libevent-${LIBEVENT_VERSION}.tar.gz"
cd "libevent-${LIBEVENT_VERSION}" || exit 1

echo "Configuring libevent-${LIBEVENT_VERSION}"
./configure \
    --prefix="${HOME}" \
    --includedir="${HOME}/include" \
    --libdir="${HOME}/lib" \
    --disable-shared \
    --disable-openssl \
    --disable-libevent-regress \
    --disable-samples

echo "Compiling libevent-${LIBEVENT_VERSION}"
make

echo "Installing libevent-${LIBEVENT_VERSION}"
make install

echo "Cleaning libevent-${LIBEVENT_VERSION}"
cd "${HOME}" || exit 1
rm -rf "${HOME}/src" || exit 1

echo "libevent-${LIBEVENT_VERSION} installed successfully!"
