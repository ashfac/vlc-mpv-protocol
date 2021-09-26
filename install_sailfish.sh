#!/bin/bash

SAILFISH_IP=192.168.1.151
SAILFISH_USER=nemo

scp lls-protocol lls-protocol.desktop ${SAILFISH_USER}@${SAILFISH_IP}:/tmp/

ssh -tt ${SAILFISH_USER}@${SAILFISH_IP} <<'ENDSSH'

cd /tmp

sudo chmod +x lls-protocol

sudo mv lls-protocol /usr/local/bin/

xdg-desktop-menu install lls-protocol.desktop

rm lls-protocol.desktop

exit

ENDSSH
