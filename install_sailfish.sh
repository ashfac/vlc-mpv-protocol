#!/bin/bash

SAILFISH_HOST=sailfish
SAILFISH_USER=nemo

scp vlc-mpv-protocol vlc-mpv-protocol.desktop ${SAILFISH_USER}@${SAILFISH_HOST}:/tmp/

ssh -tt ${SAILFISH_USER}@${SAILFISH_HOST} <<'ENDSSH'

cd /tmp

sudo chmod +x vlc-mpv-protocol

sudo mv vlc-mpv-protocol /usr/local/bin/

xdg-desktop-menu install vlc-mpv-protocol.desktop

rm vlc-mpv-protocol.desktop

exit

ENDSSH
