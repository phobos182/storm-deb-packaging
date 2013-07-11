#!/bin/sh
set -e

# Set permissions on directories
/bin/chown -R storm:storm /var/log/storm /usr/lib/storm

#DEBHELPER#

[ "$1" = "configure" ] && ldconfig

exit 0

