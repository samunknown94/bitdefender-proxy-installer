#!/usr/bin/env bash

set -e

VERSION="10.5.1"
ARCH="linux_amd64"
URL="https://github.com/erebe/wstunnel/releases/download/v${VERSION}/wstunnel_${VERSION}_${ARCH}.tar.gz"

echo "Downloading wstunnel v${VERSION}..."

cd /tmp
curl -L -o wstunnel.tar.gz "$URL"

echo "Extracting..."
tar xzf wstunnel.tar.gz

echo "Installing..."
sudo mv wstunnel /usr/local/bin/wstunnel
sudo chmod +x /usr/local/bin/wstunnel

echo "Done!"
wstunnel --version || true
