#!/bin/sh

# steepest_decentをシード値(=初期探索点)を変えて10回実行し、
# 収束するのに要した平均探索回数を算出。

gcc -lm steepest_decent_for_graph.c

for file in $(ls ./diff/)
do
  echo "" > ./diff/$file
done

# シード値を下記10パターンで試す。
seeds="1000 2000 3000 4000 5000 6000 7000 8000 9000 10000"
alphas="0.001 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0 "
for seed in $seeds
do
  for alpha in $alphas
  do
  ./a.out $seed $alpha >> ./diff/${seed}.txt
  done
  echo "\n" >>  ./diff/${seed}.txt
done

gnuplot <<EOF
set datafile separator ","
set title '各alpha 値(0.01-1)での終了座標の誤差'
set xlabel 'alpha値'
set ylabel '終了座標誤差(x,y合計)'
set terminal png font "MigMix 2M,14"
set output './DiffGraph.png'
set key outside title "seed 値" box lt 5 lw 1
plot './diff/1000.txt' using 1:2 with lp lc rgb "black" pt 5 title '1000',\
'./diff/2000.txt' using 1:2 with lp pt 5 lc rgb "grey" title '2000',\
'./diff/3000.txt' using 1:2 with lp pt 5 lc rgb "red" title '3000',\
'./diff/4000.txt' using 1:2 with lp pt 5 lc rgb "yellow" title '4000',\
'./diff/5000.txt' using 1:2 with lp pt 5 lc rgb "green" title '5000',\
'./diff/6000.txt' using 1:2 with lp pt 5 lc rgb "dark-green" title '6000',\
'./diff/7000.txt' using 1:2 with lp pt 5 lc rgb "blue" title '7000',\
'./diff/8000.txt' using 1:2 with lp pt 5 lc rgb "cyan" title '8000',\
'./diff/9000.txt' using 1:2 with lp pt 5 lc rgb "magenta" title '9000',\
'./diff/10000.txt' using 1:2 with lp pt 5 lc rgb "pink" title '10000'
EOF
echo "./DiffGraph.pngにグラフ作成完了!!!"
open ./DiffGraph.png

# シード値を下記10パターンで試す。
seeds="1000 2000 3000 4000 5000 6000 7000 8000 9000 10000"
alphas="0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9"
for seed in $seeds
do
  for alpha in $alphas
  do
  ./a.out $seed $alpha >> ./diff/${seed}-2.txt
  done
  echo "\n" >>  ./diff/${seed}-2.txt
done

gnuplot <<EOF
set datafile separator ","
set title '各alpha 値(0.1-0.9)での終了座標の誤差'
set xlabel 'alpha値'
set ylabel '終了座標誤差(x,y合計)'
set terminal png font "MigMix 2M,14"
set output './DiffGraph2.png'
set key outside title "seed 値" box lt 5 lw 1
plot './diff/1000-2.txt' using 1:2 with lp lc rgb "black" pt 5 title '1000',\
'./diff/2000-2.txt' using 1:2 with lp pt 5 lc rgb "grey" title '2000',\
'./diff/3000-2.txt' using 1:2 with lp pt 5 lc rgb "red" title '3000',\
'./diff/4000-2.txt' using 1:2 with lp pt 5 lc rgb "yellow" title '4000',\
'./diff/5000-2.txt' using 1:2 with lp pt 5 lc rgb "green" title '5000',\
'./diff/6000-2.txt' using 1:2 with lp pt 5 lc rgb "dark-green" title '6000',\
'./diff/7000-2.txt' using 1:2 with lp pt 5 lc rgb "blue" title '7000',\
'./diff/8000-2.txt' using 1:2 with lp pt 5 lc rgb "cyan" title '8000',\
'./diff/9000-2.txt' using 1:2 with lp pt 5 lc rgb "magenta" title '9000',\
'./diff/10000-2.txt' using 1:2 with lp pt 5 lc rgb "pink" title '10000'
EOF
echo "./DiffGraph2.pngにグラフ作成完了!!!"
open ./DiffGraph2.png
