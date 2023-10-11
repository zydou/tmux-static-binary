#!/bin/sh

export CC=cc
export REALCC="${CC}"
export CPPFLAGS="-P"

mkdir -p "${HOME}/src"
cd "${HOME}/src" || exit 1

echo "Downloading musl-${MUSL_VERSION}"
curl -sSLfk -o "musl-${MUSL_VERSION}.tar.gz" "https://www.musl-libc.org/releases/musl-${MUSL_VERSION}.tar.gz"

echo "Extracting musl-${MUSL_VERSION}"
tar -xzf "musl-${MUSL_VERSION}.tar.gz"

cd "musl-${MUSL_VERSION}" || exit 1

echo "Configuring musl-${MUSL_VERSION}"
./configure \
    --enable-gcc-wrapper \
    --disable-shared \
    --prefix="${HOME}" \
    --bindir="${HOME}/bin" \
    --includedir="${HOME}/include" \
    --libdir="${HOME}/lib"

echo "Compiling musl-${MUSL_VERSION}"
make

echo "Installing musl-${MUSL_VERSION}"
make install

echo "Cleaning musl-${MUSL_VERSION}"
cd "${HOME}" || exit 1
rm -rf "${HOME}/src" || exit 1

echo "musl-${MUSL_VERSION} installed successfully!"
