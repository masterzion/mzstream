#!/bin/bash

cd $(dirname $(readlink -f $0))
source ~/.mzstream

export WIDTH=1024
export HEIGHT=668
export CAM_WIDTH=260
export CAM_HEIGHT=294

export CAPTURECARD=$1
export WEBCAMSRC=$2
export AUDIO=$3

export POS_X=$4

POS_Y=$5
export POS_Y=$(echo "100-$POS_Y" | bc)

export SERVER=$6




MAX_LEFT=$(echo "$WIDTH-$CAM_WIDTH" | bc)
MAX_LEFT=$(echo "scale=2; $MAX_LEFT / 100" | bc -l)
POS_LEFT=$(echo "$MAX_LEFT * $POS_X" | bc |  cut -d. -f1)
echo "POS_LEFT $POS_LEFT"

MAX_TOP=$(echo "$HEIGHT-$CAM_HEIGHT" | bc)
MAX_TOP=$(echo "scale=2; $MAX_TOP / 100" | bc -l)
POS_TOP=$(echo "$MAX_TOP * $POS_Y" | bc |  cut -d. -f1)


echo "POS_TOP $POS_TOP"

while :
do
   ffmpeg \
    -ss 0.5 -i $WEBCAMSRC \
    -ss 5 -i $CAPTURECARD \
    -f alsa  -thread_queue_size 8K -i hw:$3 \
    -filter_complex "
   [1:v]setpts=PTS-STARTPTS:,scale=$WIDTH:-1[left];
   [0:v]setpts=PTS-STARTPTS,scale=$CAM_WIDTH:-1[right];
   [left][right]overlay=shortest=1:x=$POS_LEFT:y=$POS_TOP[v]" -map "[v]" -map  "2:a"  \
      -preset ultrafast -maxrate 2500k -bufsize 64000k  \
      -acodec libmp3lame  -q:a 1   \
      -pix_fmt yuv420p  -vcodec libx264   \
      -f flv -flags:v +global_header -rtmp_buffer 10000 -r 30 -async 1 \
      ${SERVER}${TWITCH_KEY}
   echo "Stream error..."
   sleep 3
   echo "Retrying..."
done
