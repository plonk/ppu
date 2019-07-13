#!/bin/bash

THREAD_SPEC="nichan://genkai.pcgw.pgw.jp/shuuraku/PeerCast*:postable,oldest"

while [ 1 ]
do
    URL=`shit ls $THREAD_SPEC --read-url`

    if [ ! -z $URL ]
    then
        bbiff --no-render --delay-seconds=2 --long-polling $URL
    else
        echo "移動先のスレッドが見つかりません: $THREAD_SPEC"
    fi
    echo "5秒スリープ"
    sleep 5 
done
