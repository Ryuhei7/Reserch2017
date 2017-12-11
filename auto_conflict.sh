#! /bin/bash

#/home/ryuehi/new_reserch/reserch/clone

cd clone
ccf=0 #Count of Conflict File
cff=0 #Count of Fix File
repo_counter=0 #選択リポジトリの番号
echo $repo_counter
for repo in `seq 0 99` #リポジトリの数だけ回す
do
cd $repo_counter
touch /home/ryuhei/new_reserch/reserch/clone/result_merges.txt

git log --merges --pretty=format:"%H %P" >> /home/ryuhei/new_reserch/reserch/clone/result_merges.txt
file=`cat /home/ryuhei/new_reserch/reserch/clone/result_merges.txt`

#すべてのIDを配列に格納#
count=0
for a in $file 
        do
		id[$count]=$a
        count=$((count+1))
		done
		echo "変数fileを回した件数＝$count"

#コンフリクトを探してデータセットを作る準備
		merge_count=`git log --merges --pretty=format:"%H %P" | wc -l`
		echo "再生するマージの件数＝ $merge_count"
		ccounter=0
		check=1

#コンフリクト再現スタート
		for b in `seq 1 $merge_count`
		do
		git checkout ${id[$check]} 
		git merge --no-ff ${id[$check+1]} --no-edit
		conflict=`git conflicts`

#コンフリクトを起こしたファイルがなければマスターに戻る
		if [ "$conflict" == "" ]; then
		git reset --hard HEAD

#コンフリクトを起こしたファイルがあればその後の処理
		else
        ccounter=$((ccounter+1))
		conf_file=`git conflicts`

#コンフリクトファイルをコピー
		conf_count=0
		for c in $conf_file
		do 
		conflict[$conf_count]=$c
		name=( `echo ${conflict[$conf_count]} | tr -s '/' ' '`)
		last_index=`expr ${#name[@]} - 1`
		name[$last_index]="conflict${ccf}.txt"
		cp ${conflict[$conf_count]} /home/ryuhei/new_reserch/reserch/conflict/${name[$last_index]}
		conf_count=$((counf_count+1))
        ccf=$((ccf+1))
		done

#FIXコミットにチェックアウト
		git reset --hard HEAD
		git checkout ${id[$check-1]}

#FIXファイルをコピー
		fix_count=0
		for d in $conf_file
		do 
		conflict[$fix_count]=$d
		name=( `echo ${conflict[$fix_count]} | tr -s '/' ' '`)
		last_index=`expr ${#name[@]} - 1`
		name[$last_index]="fix${cff}.txt"
		cp ${conflict[$fix_count]} /home/ryuhei/new_reserch/reserch/conflict/${name[$last_index]}
		
#特徴量を抽出
		#特徴量ファイル作成
　		touch home/ryuhei/new_reserch/reserch/seed_data/feature${cff}.txt
　		#親ブランチのAutherの総コミット数の差
		auther_name1=`git log ${id[$check]} --pretty=format:"%cn" --no-merges -n 1`
		auther_name2=`git log ${id[$check+1]} --pretty=format:"%cn" --no-merges -n 1`
		sum_commit1=`git log --no-merges --auther="$auther_name1" --oneline | wc -l`
		sum_commit2=`git log --no-merges --auther="$auther_name2" --oneline | wc -l`
		f_sum_commit=`expr $sum_commit1 - $sum_commit2`
		echo "$f_sum_commit " > home/ryuehi/new_reserch/reserch/seed_data/feature${ccf}.txt
　		
		#親ブランチのAutherの総コミット行数の差
		commit_line1=`git log --numstat --pretty="%H" --author="$auther_name1"  --no-merges | awk 'NF==3 {plus+=$1; minus+=$2} END {printf("%d\n", plus+minus)}'`
		commit_line2=`git log --numstat --pretty="%H" --author="$auther_name2"  --no-merges | awk 'NF==3 {plus+=$1; minus+=$2} END {printf("%d\n", plus+minus)}'`
		f_commit_line=`expr $commit_line1 - $commit_line2`
        echo "$f_commit_line " > home/ryuehi/new_reserch/reserch/seed_data/feature${ccf}.txt
　		
		#親ブランチのコミットメッセージの長さの差
		commit_message1=`git log ${id[$check]} --pretty=format:"%s" -n 1 --no-merges | wc -m`		
		commit_message2=`git log ${id[$check+1]} --pretty=format:"%s" -n 1 --no-merges | wc -m`		
		f_commit_message=`expr $commit_message1 - $commit_message2`
		echo "$f_commit_message " > home/ryuehi/new_reserch/reserch/seed_data/feature${ccf}.txt

		#親ブランチの最終コミットの時刻の差
		

		fix_count=$((fix_count+1))
        cff=$((cff+1))
		done
		fi

	
#次のマージの親までチェッカーを増やす
        check=$((check+3))
		git checkout master	
		done

#現在いるリポジトリの再現が終了したらIDファイルを削除して階層を一つ戻る
		rm /home/ryuhei/new_reserch/reserch/clone/result_merges.txt
		cd ..
		repo_counter=$((repo_counter+1))
		done

#最終表示項目
		#echo "マージ数: `expr $merge_count + 1` 回"
		#echo "コンフリクト数: $ccounter 回"



		　

