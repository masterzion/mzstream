#!/bin/bash

export RESOLUTION=1280x720
export CAPTURECARD=$1
export WEBCAMSRC=$2
export AUDIO=$3
export SERVER=$4
export TOP_POS_CAM=24
export LEFT_POS_CAM=900


while :
do
   ffmpeg \
    -ss 0.5 -i $WEBCAMSRC \
    -ss 5 -i $CAPTURECARD \
    -f alsa  -thread_queue_size 8K -i hw:$3 \
    -filter_complex "
   [1:v]setpts=PTS-STARTPTS:,scale=1024:-1[left];
   [0:v]setpts=PTS-STARTPTS,scale=260x150:[right];
   [left][right]overlay=shortest=1:x=750:y=20[v]" -map "[v]" -map  "2:a"  \
      -preset ultrafast -maxrate 2000k -bufsize 64000k  \
      -acodec libmp3lame  -q:a 1   \
      -pix_fmt yuv420p  -vcodec libx264   \
      -f flv -flags:v +global_header -rtmp_buffer 10000 -r 30 -async 1 \
      ${SERVER}${TWITCH_KEY}
 exit
   echo "Stream error..."
   sleep 3
   echo "Retrying..."
done





