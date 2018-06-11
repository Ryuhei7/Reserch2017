#! /bin/bash

commit_time1=(1243241 +0900)
commit_time2=(1533153 +1300)

time_conv1=(`echo ${commit_time1[1]} | cut -c 2` `echo ${commit_time1[1]} | cut -c 3` `echo ${commit_time1[1]} | cut -c 4` `echo ${commit_time1[1]} | cut -c 5`)
time_conv2=(`echo ${commit_time2[1]} | cut -c 2` `echo ${commit_time2[1]} | cut -c 3` `echo ${commit_time2[1]} | cut -c 4` `echo ${commit_time2[1]} | cut -c 5`)

plus_time1=$((${time_conv1[0]}*36000 + ${time_conv1[1]}*3600 +${time_conv1[2]}*600 + ${time_conv1[3]}*60))
plus_time2=$((${time_conv2[0]}*36000 + ${time_conv2[1]}*3600 +${time_conv2[2]}*600 + ${time_conv2[3]}*60))

fea_name="aaaa.txt"
touch /home/ryuhei/new_reserch/reserch/seed_data/${fea_name}
auther_name1=`git log 08e45b39e76419f63aa43d5008257789d8a30bf8 --pretty=format:"%cn" --no-merges -n 1`
echo $auther_name1

echo $plus_time1
echo $plus_time2
f=$(($plus_time1 - $plus_time2))
b=1
aa="test${b}.txt"
touch ${aa}
echo "$f $f $f" >> test1.txt

echo "$f"
