#!/bin/sh
set -e

/usr/sbin/deluser storm

#DEBHELPER#

[ "$1" = "configure" ] && ldconfig

exit 0

