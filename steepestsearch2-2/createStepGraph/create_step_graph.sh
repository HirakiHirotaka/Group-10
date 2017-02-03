#!/bin/sh

# steepest_decentをシード値(=初期探索点)を変えて10回実行し、
# 収束するのに要した平均探索回数を算出。

gcc -lm steepest_decent_for_graph.c

for file in $(ls ./step/)
do
  echo "" > ./step/$file
done

# シード値を下記10パターンで試す。
seeds="1000 2000 3000 4000 5000 6000 7000 8000 9000 10000"
alphas="0.001 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0 "
for seed in $seeds
do
  for alpha in $alphas
  do
  ./a.out $seed $alpha >> ./step/${seed}.txt
  done
  echo "\n" >>  ./step/${seed}.txt
done

gnuplot <<EOF
set datafile separator ","
set title '各alpha 値(0.001-1.0)での終了step数'
set xlabel 'alpha値'
set ylabel 'step数'
set terminal png font "MigMix 2M,14"
set output './StepGraph.png'
set key outside title "seed 値" box lt 5 lw 1
plot './step/1000.txt' using 1:2 with lp lc rgb "black" pt 5 title '1000',\
'./step/2000.txt' using 1:2 with lp pt 5 lc rgb "grey" title '2000',\
'./step/3000.txt' using 1:2 with lp pt 5 lc rgb "red" title '3000',\
'./step/4000.txt' using 1:2 with lp pt 5 lc rgb "yellow" title '4000',\
'./step/5000.txt' using 1:2 with lp pt 5 lc rgb "green" title '5000',\
'./step/6000.txt' using 1:2 with lp pt 5 lc rgb "dark-green" title '6000',\
'./step/7000.txt' using 1:2 with lp pt 5 lc rgb "blue" title '7000',\
'./step/8000.txt' using 1:2 with lp pt 5 lc rgb "cyan" title '8000',\
'./step/9000.txt' using 1:2 with lp pt 5 lc rgb "magenta" title '9000',\
'./step/10000.txt' using 1:2 with lp pt 5 lc rgb "pink" title '10000'
EOF
echo "./StepGraph.pngにグラフ作成完了!!!"
open ./StepGraph.png

seeds="1000 2000 3000 4000 5000 6000 7000 8000 9000 10000"
alphas="0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9"
for seed in $seeds
do
  for alpha in $alphas
  do
  ./a.out $seed $alpha >> ./step/${seed}-2.txt
  done
  echo "\n" >>  ./step/${seed}-2.txt
done

gnuplot <<EOF
set datafile separator ","
set title '各alpha 値(0.1-0.9)での終了step数'
set xlabel 'alpha値'
set ylabel 'step数'
set terminal png font "MigMix 2M,14"
set output './StepGraph2.png'
set key outside title "seed 値" box lt 5 lw 1
plot './step/1000-2.txt' using 1:2 with lp lc rgb "black" pt 5 title '1000',\
'./step/2000-2.txt' using 1:2 with lp pt 5 lc rgb "grey" title '2000',\
'./step/3000-2.txt' using 1:2 with lp pt 5 lc rgb "red" title '3000',\
'./step/4000-2.txt' using 1:2 with lp pt 5 lc rgb "yellow" title '4000',\
'./step/5000-2.txt' using 1:2 with lp pt 5 lc rgb "green" title '5000',\
'./step/6000-2.txt' using 1:2 with lp pt 5 lc rgb "dark-green" title '6000',\
'./step/7000-2.txt' using 1:2 with lp pt 5 lc rgb "blue" title '7000',\
'./step/8000-2.txt' using 1:2 with lp pt 5 lc rgb "cyan" title '8000',\
'./step/9000-2.txt' using 1:2 with lp pt 5 lc rgb "magenta" title '9000',\
'./step/10000-2.txt' using 1:2 with lp pt 5 lc rgb "pink" title '10000'
EOF
echo "./StepGraph2.pngにグラフ作成完了!!!"
open ./StepGraph2.png


