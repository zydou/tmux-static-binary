#!/bin/sh

export CC="${HOME}/bin/musl-gcc -static"
export REALCC="cc"
export CPPFLAGS="-P"

mkdir -p "${HOME}/src"
cd "${HOME}/src" || exit 1

echo "Downloading tmux-${TMUX_VERSION}"
curl -sSLfk -o "tmux-${TMUX_VERSION}.tar.gz" "https://github.com/tmux/tmux/releases/download/${TMUX_VERSION}/tmux-${TMUX_VERSION}.tar.gz"

echo "Extracting tmux-${TMUX_VERSION}"
tar -xzf "tmux-${TMUX_VERSION}.tar.gz"
cd "tmux-${TMUX_VERSION}" || exit 1

echo "Configuring tmux-${TMUX_VERSION}"
./configure --prefix="${HOME}" \
    --enable-static \
    --includedir="${HOME}/include" \
    --libdir="${HOME}/lib" \
    CFLAGS="-I${HOME}/include" \
    LDFLAGS="-L${HOME}/lib" \
    CPPFLAGS="-I${HOME}/include" \
    LIBEVENT_LIBS="-L${HOME}/lib -levent" \
    LIBNCURSES_CFLAGS="-I${HOME}/include/ncurses" \
    LIBNCURSES_LIBS="-L${HOME}/lib -lncurses" \
    LIBTINFO_CFLAGS="-I${HOME}/include/ncurses" \
    LIBTINFO_LIBS="-L${HOME}/lib -ltinfo"

# patch file.c
# sed -i 's|#include <sys/queue.h>||g' file.c

echo "Compiling tmux-${TMUX_VERSION}"
make

echo "Installing tmux-${TMUX_VERSION}"
make install

echo "Stripping tmux-${TMUX_VERSION}"
strip "${HOME}/bin/tmux"

echo "Cleaning tmux-${TMUX_VERSION}"
cd "${HOME}" || exit 1
rm -rf "${HOME}/src" || exit 1

echo "tmux-${TMUX_VERSION} installed successfully!"
