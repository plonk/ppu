#!/bin/bash

while [ 1 ]
do
    URL=`tsugisure`

    if [ ! -z $URL ]
    then
        bbiff --no-render $URL
    fi
    echo "10秒スリープ"
    sleep 10
done
