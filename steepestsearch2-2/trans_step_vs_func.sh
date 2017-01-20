#!/bin/bash
set -e

# 探索推移プロットスクリプト(1変数用)。

# 図タイトル(fig_title), シード値(seed) の取得。
if [ $# -eq 2 ] ; then
    fig_title=$1
    seed=$2
else
    echo "Usage: prompt> $0 \"figure_title\" seed"
    echo "e.g.,: prompt> $0 \"y=x\" 1"
    exit 0
fi

# シミュレーション実行＆データ抽出。
exec_file="./steepest_decent"
transition_file="./transition.txt"

if [ -f $transition_file ] ; then
    rm $transition_file
fi

archive_file=.archive-$seed
data_file=.data-$seed
$exec_file $seed > $archive_file
cat $archive_file | cut -f2,4,6,8 -d" " > $data_file

# 作図。
gnuplot<<EOF
set terminal svg
set output "sim-$seed.svg"
set title "$fig_title"
set xlabel "steps"
set ylabel "f(x)"
plot "$data_file" using 1:4 with lp
EOF