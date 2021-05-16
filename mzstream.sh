
#!/bin/bash

export RESOLUTION=1024x768
export CAPTURECARD=$1
export WEBCAMSRC=$2
export AUDIO=$3
export TOP_POS_CAM=24
export LEFT_POS_CAM=900

/usr/local/bin/ffmpeg -i $CAPTURECARD  -i  $WEBCAMSRC -f alsa -i hw:$3 -filter_complex "
[0:v]setpts=PTS-STARTPTS,scale=$RESOLUTION:[left];
[1:v]setpts=PTS-STARTPTS,scale=260x150:[right];
[left][right]overlay=shortest=1:x=750:y=20[v]" -map "[v]" -map  "2:a"  -y -r 30   -b:v 6000k -maxrate 6000k -bufsize 6000k -pix_fmt yuv420p -g 50 -c:a aac -b:a 160k -ac 2 -ar 44100 -video_size 1024x768 -c:v libx264 -f rtmp://live.twitch.tv/app/$TWITCH_KEY
