#!/bin/bash

mkdir -p /conf
mkdir -p /data/worlds

# Create a user if not done already.
if ! grep "abc" /etc/passwd; then
    groupadd --gid "$PGID" abc
    useradd -M --gid "$PGID" --uid "$PUID" abc
fi

# Download TShock if not done already.
if [[ ! -f "/data/.tshock-installed" ]]; then
    touch /data/.tshock-installed

    echo "[!] TShock not found. Downloading and installing..."
    curl -Lo /tmp/tshock.zip "https://github.com/Pryaxis/TShock/releases/download/v4.5.0/TShock4.5.0_Terraria1.4.2.1.zip"
    unzip /tmp/tshock.zip -d /data
fi

# Make a copy of the default config if none present.
if [[ ! -f "/conf/server_config.cfg" ]]; then
    echo "[!] No config found. Creating a default..."
    cp /server_config.cfg /conf/server_config.cfg
fi

# Fix permissions.
chown -R abc:abc /conf
chown -R abc:abc /data

# Start TShock
su-exec abc mono --server --gc=sgen -O=all /data/TerrariaServer.exe -config /conf/server_config.cfg
