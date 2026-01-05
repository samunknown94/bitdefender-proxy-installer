#!/usr/bin/env bash
set -e

VERSION="10.5.1"
ARCH="linux_amd64"
URL="https://github.com/erebe/wstunnel/releases/download/v${VERSION}/wstunnel_${VERSION}_${ARCH}.tar.gz"

echo "[1/4] Downloading wstunnel..."
cd /tmp
curl -L -o wstunnel.tar.gz "$URL"
tar xzf wstunnel.tar.gz

echo "[2/4] Installing binary..."
mv wstunnel /usr/local/bin/wstunnel
chmod +x /usr/local/bin/wstunnel

echo "[3/4] Creating systemd service..."
cat <<EOF > /etc/systemd/system/wstunnel.service
[Unit]
Description=WSTunnel Client Service
After=network.target
Wants=network-online.target

[Service]
Type=simple
ExecStart=/usr/local/bin/wstunnel client wss://dwcnd1.bitdefender.sbs -L tcp://127.0.0.1:8080:127.0.0.1:8888
Restart=always
RestartSec=5
User=root
LimitNOFILE=1048576

[Install]
WantedBy=multi-user.target
EOF

echo "[4/4] Enabling service..."
systemctl daemon-reexec
systemctl daemon-reload
systemctl enable wstunnel
systemctl restart wstunnel

echo "✅ wstunnel service installed and running"
systemctl status wstunnel --no-pager
