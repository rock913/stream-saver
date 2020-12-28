#!/bin/bash

####help
# show video stream
# ffplay /dev/video0

# To list all video devices picked up by the kernel
# ls -ltrh /dev/video*

# record video by k4arecorder
# k4arecorder -r 15 --imu OFF ${k4a_file}/k4a.mkv &

# ffplay -t 5 -autoexit music.mp3&

foldr=`date +%Y_%m_%d%_H%M%S`
mkdir -p $foldr

v_list=`ls /dev/video*`

for vid in $v_list; do
  echo $vid
  echo ${vid#*dev/}
done &

exit

k4a_file=${foldr}/k4a
mkdir -p $k4a_file

echo a $$
echo c $!


echo "Press 'q' to stop recording"
while : ; do
  read -n 1 key <&1
  if [[ $key = q ]] ; then
    printf "\nQuitting from the program\n"
    pstree $$ -p | awk -F'[()]' '{for(i=0;i<=NF;i++)if($i~/(^[0-9])+/)print $i}' | xargs kill -SIGINT
    # kill -SIGINT $$
    break
  fi
done
