#!/bin/sh
set -e

# steepest_decentをシード値(=初期探索点)を変えて10回実行し、
# 収束するのに要した平均探索回数を算出。

exec_file="./steepest_decent"
average_file="./average.txt"

if [ -f $average_file ] ; then
    rm $average_file
fi

# シード値を下記10パターンで試す。
seeds="1000 2000 3000 4000 5000 6000 7000 8000 9000 10000"
sim=0
for seed in $seeds
do
    sim=`expr $sim + 1`
    $exec_file $seed > .archive-$seed
    # シミュレーション結果から試行回数10回分を抜き出す。
    tail -1 .archive-$seed | cut -f2 -d" " >> $average_file
    /bin/echo -n "sim $sim: seed=$seed -> step="
    /bin/echo `tail -1 $average_file`
done

# 平均試行回数を計算
steps=`cat $average_file`
sum=0
for step in $steps
do
    sum=`expr $sum + $step`
done
/bin/echo -n "average step = "
bc<<EOF
scale=2;
$sum/10
EOF
