#!/bin/sh
set -e

# steepest_decentをSeedを変更後,20回実行
# 収束するのに要した平均探索回数を算出。
# FINISH2以外のものでも集計しているので,記録としての正確性にはやや疑問が残る

exec_file="./steepest_decent"
average_file="./seed_trans.txt"
result_file="./seed_trans.txt"
pdf_title="./seed_total.pdf"
alpha=0.1

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
seed=1000

for roop in ${roops[@]}
do
    sim=`expr $sim + 1`
    $exec_file $seed $alpha > .archive-$sim
    archive_file=.archive-$sim
    data_file=.data-$seed.txt
    cat $archive_file | cut -f4,8 -d" " > $data_file
    #1000ずつ足していく
    seed=`echo "$seed"|awk '{print $1 +1000}'`
done

gnuplot<<EOF
set term pdf
set xlabel "Step"
set ylabel "f(x)"
set output "${pdf_title}"
plot ".data-1000.txt" w linespoints title "1000",".data-6000.txt" w linespoints title "6000", ".data-11000.txt" w linespoints title "11000", ".data-12000.txt" w linespoints title "12000",".data-13000.txt" w linespoints title "13000",".data-17000.txt" w linespoints title "17000", x*cos(x) lc rgb "red"w lines
EOF
