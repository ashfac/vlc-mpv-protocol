This is a collection of custom protocol handlers to open video links directly in VLC and/or MPV Media Players.

A custom plugin of TinyTinyRSS adds vlc:// or mpv:// to the beginning of a video URL to allow it to be opened in these players directly.

## Install VLC Player

```
sudo snap install vlc
```

## Install MPV Media Player

```
sudo apt install -y mpc
```

## Open video in VLC Player

To open a video url on the command line in VLC , use the following command

```
xdg-open vlc://https://www.youtube.com/watch?v=H7D-k-_3phI
```

## Open video in MPV Media Player

To open a video url on the command line in MPV Media Player , use the following command

```
xdg-open mpv://https://www.youtube.com/watch?v=H7D-k-_3phI
```

