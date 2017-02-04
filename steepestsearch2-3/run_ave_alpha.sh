#!/bin/sh
set -e

# steepest_decentをAlpha(学習係数)を変更後,20回実行
# 収束するのに要した平均探索回数を算出。
# FINISH2以外のものでも集計しているので,記録としての正確性にはやや疑問が残る

exec_file="./steepest_decent"
average_file="./average.txt"
result_file="./result.txt"
pdf_title="./alpha_ave.pdf"
seed=1000

if [ -f $average_file ] ; then
    rm $average_file
fi

if [ -f $result_file ] ; then
    rm $result_file
fi

# 20パターンで試す。
roops=()

i=0

while [ $i -lt 20 ]
do
    i=`expr $i + 1`
    roops[$i]=$i
done
#roops="1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 "
sim=0
alpha=0.01

for roop in ${roops[@]}
do
    sim=`expr $sim + 1`
    $exec_file $seed $alpha > .archive-$seed
    # シミュレーション結果から試行回数10回分を抜き出す。
    tail -1 .archive-$seed | cut -f2 -d" " >> $average_file
    /bin/echo -n "$alpha `tail -1 $average_file`" >> $result_file
    #改行を挿入
    /usr/bin/printf "\n" >>$result_file
    #0.1ずつ足していく
    alpha=`echo "$alpha"|awk '{print $1 +0.1}'`
done

gnuplot<<EOF
set term pdf
set xlabel "Alpha"
set ylabel "Step"
set output "${pdf_title}"
plot "${result_file}" w linespoints 
EOF

