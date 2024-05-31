#!/usr/bin/bash
#
udisksctl mount -b /dev/sdc2

sudo mount -o bind /dev "/run/media/$USER/blob/dev"
sudo mount -o bind /dev/pts "/run/media/$USER/blob/dev/pts"
sudo mount -o bind /proc "/run/media/$USER/blob/proc"
sudo mount -o bind /sys "/run/media/$USER/blob/sys"
sudo mount -o bind /run "/run/media/$USER/blob/run"
