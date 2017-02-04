#!/bin/sh
pdf_title=$1
result_file=$2

gnuplot<<EOF
set term pdf
set xlabel "Alpha"
set ylabel "Average"
set output "${pdf_title}"
plot "${result_file}" w linespoints
EOF
