#!/bin/bash

sudo chmod +x vlc-protocol vlca-protocol mpv-protocol

sudo cp vlc-protocol vlca-protocol mpv-protocol /usr/local/bin/

xdg-desktop-menu install vlc-protocol.desktop vlca-protocol.desktop mpv-protocol.desktop


