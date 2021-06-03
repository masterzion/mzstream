#!/bin/bash
remove_file () {
  [ -e  $1 ] && rm $1
}

kill_process () {
  count=$(ps -aux | grep $1 | wc -l)
  if [[ "$count" != "1" ]]; then
    killall $1
  fi
}

remove_file web/run.txt
kill_process mzstream.sh
kill_process ffmpeg

#python http.py $WEBUI_PORT &
while :
do
  [ ! -e web/drivers.json ] && ./listinterfaces.sh
  sleep 1
  count=$(ps -aux | grep  mzstream.sh | wc -l)
  if [[ -e web/run.txt ]]; then
    if [[ "$count" == "1" ]]; then
      echo run
      audio=$(cat web/config.json | grep audio_id  | cut -d: -f2 | tr -d ',' | tr -d '"')
      capture=$(cat web/config.json | grep capture_id  | cut -d: -f2 | tr -d ',' | tr -d '"')
      webcam=$(cat web/config.json | grep webcam_id  | cut -d: -f2 | tr -d ',' | tr -d '"')
      val_x=$(cat web/config.json | grep val_x  | cut -d: -f2 | tr -d ',' | tr -d '"')
      val_y=$(cat web/config.json | grep val_y  | cut -d: -f2 | tr -d ',' | tr -d '"')

      ./mzstream.sh $capture $webcam $audio $val_x $val_y $TWITCH_URL &
    fi
    sleep 5
  else
    if [[ "$count" != "1" ]]; then
      echo stop
      kill_process mzstream.sh
      kill_process ffmpeg
    fi
  fi
done
