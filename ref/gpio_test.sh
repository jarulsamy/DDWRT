#!/bin/sh

# Caution when utilizing this script
# Most routers have the factory reset functionality
# bound to one of the GPIO pins. Take backups before
# using this script.

i=13
end=30
while [ $i -le $end ]; do
    echo $i
    gpio disable $i
    sleep 2
    gpio enable $i
    sleep 2
    i=$(($i + 1))
done
