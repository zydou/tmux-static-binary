#!/bin/sh

OS=$(uname -s | tr '[:upper:]' '[:lower:]')

case "$(uname -m)" in
    "x86_64")
        ARCH="amd64"
        ;;
    "aarch64")
        ARCH="arm64"
        ;;
    "armv7l")
        ARCH="arm"
        ;;
    *)
        ARCH=$(uname -m)
        ;;
esac

mkdir -p "${HOME}/src"
cd "${HOME}/src" || exit 1

echo "Downloading upx-${UPX_VERSION}-${ARCH}_${OS}"
curl -sSLfk -o "upx-${UPX_VERSION}-${ARCH}_${OS}.tar.xz" "https://github.com/upx/upx/releases/download/v${UPX_VERSION}/upx-${UPX_VERSION}-${ARCH}_${OS}.tar.xz"

echo "Extracting upx-${UPX_VERSION}"
tar -xJf "upx-${UPX_VERSION}-${ARCH}_${OS}.tar.xz"
cd "upx-${UPX_VERSION}-${ARCH}_${OS}" || exit 1


echo "Compressing tmux using upx-${UPX_VERSION}"
cp "${HOME}/bin/tmux" "${HOME}/bin/tmux-upx"
./upx --best --ultra-brute "${HOME}/bin/tmux-upx"

echo "upx-${UPX_VERSION} compressed successfully!"
