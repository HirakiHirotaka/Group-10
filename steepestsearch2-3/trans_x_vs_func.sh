#!/bin/bash
set -e

# 探索推移プロットスクリプト(1変数用)。
# x vs f(x)

# 図タイトル(func), シード値(seed) の取得。
if [ $# -eq 2 ] ; then
    func=$1
    seed=$2
else
    echo "Usage: prompt> $0 \"gnuplot_style_func\" seed"
    echo "e.g.,: prompt> $0 \"x**2\" 1"
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
set terminal svg
set output "sim-$seed.svg"
set title "$func"
set xlabel "steps"
set ylabel "f(x)"
plot $func w d, "$data_file" using 2:4 with lp
EOF