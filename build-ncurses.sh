#!/bin/sh

export CC="${HOME}/bin/musl-gcc -static"
export REALCC="cc"
export CPPFLAGS="-P"

mkdir -p "${HOME}/src"
cd "${HOME}/src" || exit 1

echo "Downloading ncurses-${NCURSES_VERSION}"
curl -sSLfk -o ncurses.tar.gz "https://github.com/mirror/ncurses/archive/refs/tags/${NCURSES_VERSION}.tar.gz"

echo "Extracting ncurses-${NCURSES_VERSION}"
tar --strip-components 1 -xzf ncurses.tar.gz

echo "Configuring ncurses-${NCURSES_VERSION}"
./configure \
    --prefix="${HOME}" \
    --includedir="${HOME}/include" \
    --libdir="${HOME}/lib" \
    --enable-pc-files \
    --with-pkg-config="${HOME}/lib/pkgconfig" \
    --with-pkg-config-libdir="${HOME}/lib/pkgconfig" \
    --without-ada \
    --without-tests \
    --without-manpages \
    --with-ticlib \
    --with-termlib \
    --with-default-terminfo-dir=/usr/share/terminfo \
    --with-terminfo-dirs=/etc/terminfo:/lib/terminfo:/usr/share/terminfo

echo "Compiling ncurses-${NCURSES_VERSION}"
make

echo "Installing ncurses-${NCURSES_VERSION}"
make install

echo "Cleaning ncurses-${NCURSES_VERSION}"
cd "${HOME}" || exit 1
rm -rf "${HOME}/src" || exit 1

echo "ncurses-${NCURSES_VERSION} installed successfully!"
