
echo "=================== VIDEO INTERFACES ==================="
for d in /dev/video* ; do echo $d ; v4l2-ctl --device=$d -D --list-formats   ; done 


echo "=================== AUDIO INTERFACES ==================="
arecord -l
