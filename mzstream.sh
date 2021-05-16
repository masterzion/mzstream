#!/bin/bash

export RESOLUTION=1024x768
export CAPTURECARD=$1
export WEBCAMSRC=$2
export AUDIO=$3
export SERVER=$4
export TOP_POS_CAM=24
export LEFT_POS_CAM=900


ffmpeg -i /dev/video2 -i /dev/video4 -f alsa -i hw:$3 -filter_complex "
[0:v]setpts=PTS-STARTPTS,scale=$RESOLUTION:[left];
[1:v]setpts=PTS-STARTPTS,scale=260x150:[right];
[left][right]overlay=shortest=1:x=750:y=20[v]" -map "[v]" -map  "2:a" \
        -vcodec libx264 -preset fast -maxrate 2000  -s "$RESOLUTION"\
        -acodec libmp3lame -ar 44100 -q:a 1   \
        -pix_fmt yuv420p -f flv temp.flv



