#!/bin/sh
i=13
end=30
while [ $i -le $end ]; do
        echo $i
        gpio disable $i
        sleep 2
        gpio enable $i
        sleep 2
            i=$(($i+1))
        done
