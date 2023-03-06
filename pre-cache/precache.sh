#!/bin/bash

set -e

rm -rf /host/tmp/precache
rm -f /host/tmp/images.txt
cp -a /opt/precache /host/tmp/
cp -rf /etc/config /host/tmp/precache/config
# only check space for OCP upgrade
if [ -n "$(cat /etc/config/platform.image)" ]; then
    /opt/precache/check_space
fi

# First pass
time chroot /host /tmp/precache/release
time chroot /host /tmp/precache/olm
time chroot /host /tmp/precache/pull

# Second pass
time chroot /host /tmp/precache/release
time chroot /host /tmp/precache/olm
time chroot /host /tmp/precache/pull
