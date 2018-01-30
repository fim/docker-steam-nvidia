Steam Docker with Nvidia 3d acceleration
================

Steam running in docker with nvidia h/ware 3d acceleration (requires pulseaudio for sound)

Build
=====

```
docker build --build-arg NVIDIA_DRIVER=390.12 -t steam-nvidia .
```

Run
===

```
$ install -m 755 steam /usr/local/bin
$ /usr/local/bin/steam
```
