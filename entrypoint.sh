#!/bin/bash

USER=${USER:-steam}

# Fix snd ownership
SND_HOST_GID=$(stat -c "%g" /dev/snd/$(ls /dev/snd/ |head -1))
grep $SND_HOST_GID /etc/group || groupadd -g $SND_HOST_GID host-audio
groupadd -g $USER_GID $USER
useradd -m $USER -u $USER_UID -g $USER_GID -G $(getent group $SND_HOST_GID|cut -f1 -d":")
mkdir -p /home/$USER/.local/share && chown $USER /home/$USER/.local/share
ln -snf /mnt/Steam /home/$USER/.local/share/Steam

# Run steam as USER
su - $USER -c "dbus-run-session steam"
