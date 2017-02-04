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
sim=0
alpha=0.01

for roop in ${roops[@]}
do
    sim=`expr $sim + 1`
    $exec_file $seed $alpha > .archive-$sim
    archive_file=.archive-$sim
    data_file=.data-$alpha.txt
    cat $archive_file | cut -f4,8 -d" " > $data_file
    #0.1ずつ足していく
    alpha=`echo "$alpha"|awk '{print $1 +0.1}'`
done

gnuplot<<EOF
set term pdf
set xlabel "Alpha"
set ylabel "Step"
set output "${pdf_title}"
plot ".data-0.41.txt" w linespoints title "0.41",".data-0.51.txt" w linespoints title "0.51", ".data-0.61.txt" w linespoints title "0.61", ".data-1.71.txt" w linespoints title "1.71",".data-1.81.txt" w linespoints title "1.81",".data-1.91.txt" w linespoints title "1.91", x*cos(x) w linespoints
EOF
