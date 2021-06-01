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
   ffmpeg -i $CAPTURECARD -vsync 0 -i $WEBCAMSRC -f alsa -thread_queue_size 2048 -i hw:$3 -filter_complex "
   [0:v]setpts=PTS-STARTPTS:,scale=1024:-1[left];
   [1:v]setpts=PTS-STARTPTS,scale=260x150:[right];
   [left][right]overlay=shortest=1:x=750:y=20[v]" -map "[v]" -map  "2:a"  \
      -threads 8 -preset ultrafast -maxrate 1500k -bufsize 64000k   \
      -acodec libmp3lame  -q:a 1   \
      -pix_fmt yuv420p  -vcodec libx264  -f flv \
      ${SERVER}${TWITCH_KEY}

   echo "Stream error..."
   sleep 3
   echo "Retrying..."
done





