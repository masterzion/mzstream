#!/bin/bash

DIR=$(dirname "$(readlink -f "$0")")

kill_process () {
  count=$(ps -aux | grep $1 | wc -l)
  if [[ "$count" != "1" ]]; then
    killall $1
  fi
}


if [[ "$1" == "--uninstall" ]]; then
  crontab -l | grep -v mzstream_backend.sh > mycron.tmp
  kill_process mzstream_backend.sh
  kill_process mzstream.sh
  kill_process ffmpeg
else
  crontab -l > mycron.tmp

  count=$(cat mycron.tmp | grep mzstream_backend.sh  | wc -l)

  if [[ "$count" == "0" ]]; then
    echo "@reboot ${DIR}/mzstream_backend.sh" >> mycron.tmp
  fi

  count=$(ps -aux | grep mzstream_backend.sh | wc -l)
  if [[ "$count" == "1" ]]; then
    ./mzstream_backend.sh
  fi

fi

cat mycron.tmp
crontab mycron.tmp
rm mycron.tmp
