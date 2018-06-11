#! /bin/bash

for a in `seq 0 105`
	do
	 data=(`cat learn$a.txt`)
	 
	  for b in `seq 0 7`
		do
		data[$b]=`python3 int_to_float.py ${data[$b]}`
		done

	 psql reserch -c "insert into reserch(commit, line, message, time, ngram, leven, code, flag) values(${data[0]}, ${data[1]}, ${data[2]}, ${data[3]}, ${data[4]}, ${data[5]}, ${data[6]}, ${data[7]});"
	done

