#!/bin/sh
#
for i in 1 6 8 9 12 13 ; do /sbin/gpio enable $i ; done
for i in 10 11 ; do /sbin/gpio disable $i ; done

/jffs/bin/et robowr 0x0 0x18 0x1ff
/jffs/bin/et robowr 0x0 0x18 0x0
/jffs/bin/et robowr 0x0 0x1a 0x0
/jffs/bin/et robowr 0x0 0x16 0x0
