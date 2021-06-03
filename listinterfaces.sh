#!/bin/bash

echo "=================== VIDEO INTERFACES ==================="
videolist=
echo $videolist
declare -a arinput=()
declare -a arname=()
declare -a arformat=()
for d in $(ls /dev/video*) ; do
      arinput+=($d)

      while read -r line
      do
        if [[ "$line" == *"Card type"* ]]; then
          nametemp=$(echo $line | cut -d: -f2 | xargs)
          nametemp="${nametemp// /_}"
          arname+=($nametemp)
        fi

        if [[ "$line" == *"Driver Info"* ]]; then
          addcaptureline=false
          vformat="_"
        fi

        if [[ $addcaptureline = true ]]; then
          linetemp=$(echo $line | cut -d: -f2 | cut -d\( -f1 | xargs)
          vformat=$(echo $vformat $linetemp)
          vformat="${vformat// /_}"
        fi


        if [[ "$line" == "Type: Video Capture" ]]; then
          addcaptureline=true
        fi
      done <<< $(v4l2-ctl --device=$d -D --list-formats)

      if [[ "$vformat" != "_" ]]; then
        vformat="${vformat:1}"
      fi
      arformat+=($vformat)
done

lastline=$(echo "${#arformat[@]}"-1 | bc)

echo "{" > web/drivers.json

echo "  \"video\": {" >> web/drivers.json

for i in "${!arformat[@]}"; do
  vformat=$(printf "%s" "${arformat[i]}")
  vformat="${vformat:1}"
  name=$(printf "\"%s\":\"%s(%s)\"" "${arinput[i]}" "${arname[i]}" "$vformat")
  name="${name//_/ }"
  if [[ ! $i = $lastline ]]; then
     name="$name,"
  fi

  echo "    $name"  >> web/drivers.json
done
echo "  }," >> web/drivers.json


lastline=$(arecord -l | grep card  | wc -l)
lastline=$(echo "$lastline"-1 | bc)
echo "  \"audio\": {" >> web/drivers.json
i=0
while read -r line
do
     driver=$(echo $line | cut -d: -f1)
     name=$(echo $line | cut -d: -f2 | cut -d, -f1)
     driver=$(echo $driver | sed 's/card //')
     snd=$(echo "\"$driver\":\"$name\"")
     if [[ ! $i = $lastline ]]; then
        snd="$snd,"
     fi
     i=$(expr $i + 1)
     echo "    $snd"  >> web/drivers.json

done <<< $(arecord -l | grep card)
echo "  }" >> web/drivers.json

echo "}" >> web/drivers.json

cat web/drivers.json
