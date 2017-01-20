#!/bin/bash
set -e

# 探索推移プロットスクリプト(2変数用)。
# xy vs f(x,y)

# 図タイトル(func), シード値(seed) の取得。
if [ $# -eq 2 ] ; then
    func=$1
    seed=$2
else
    echo "Usage: prompt> $0 \"gnuplot_style_func\" seed"
    echo "e.g.,: prompt> $0 \"(x**2 + (y**2)/10)\" 1"
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
set xrange [-10:10]
set yrange [-10:10]
#set grid
#set contour
set terminal svg
set output "sim-$seed.svg"
set title "$func"
set xlabel "x"
set ylabel "y"
set zlabel "f(x,y)"
splot $func w d, "$data_file" using 2:3:4 with lp
EOF