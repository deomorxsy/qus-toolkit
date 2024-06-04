#!/usr/bin/sh
#
device=$1
uuid=$(sudo blkid /dev/sdc2 | awk '{print $2}' | sed 's/^[^"]*"\([^"]*\)".*/\1/')

up() {
echo "mounting device and pseudo-filesystems..."
udisksctl mount -b "$device"
# on target rootfs, bind local rootfs directories in the
# chroot target rootfs
for f in 'dev' 'dev/pts' 'proc' 'sys' 'run'; do
   sudo mount --bind "/$f" "/run/media/$USER/$uuid/$f";
done
}

down() {
echo "UNmounting pseudo-filesystems in reverse order and device..."
for f in 'run' 'sys' 'proc' 'dev/pts' 'dev'; do
    sudo umount "/run/media/$USER/$uuid/$f";
done

udisksctl unmount -b "$device"
}

# if uuid appears under proc/mounts, unmount; else mount
if grep -qs "$uuid" /proc/mounts; then
    down
else
    up
fi

