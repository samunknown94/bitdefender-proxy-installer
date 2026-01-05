#!/usr/bin/env bash
set -e

VERSION="10.5.1"
ARCH="linux_amd64"
URL="https://github.com/erebe/wstunnel/releases/download/v${VERSION}/wstunnel_${VERSION}_${ARCH}.tar.gz"

echo "[1/2] Downloading wstunnel..."
cd /tmp
curl -L -o wstunnel.tar.gz "$URL"
tar xzf wstunnel.tar.gz

echo "[2/2] Installing binary..."
mv wstunnel /usr/local/bin/wstunnel
chmod +x /usr/local/bin/wstunnel

echo "✅ wstunnel service installed and running"
systemctl status wstunnel --no-pager
