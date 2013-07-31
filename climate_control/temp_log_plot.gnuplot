set title "Mµseum environmental log"
set datafile separator ','
set xdata time
set autoscale xy
set timefmt x '%Y-%m-%dT%H:%M:%S'
set format x "%d %H:%M"
set format y "%g%%"
set format y2 "%0.1f°C"
unset key
set ylabel "Humidity" textcolor rgb 'red'
set y2label "Temperature" textcolor rgb 'blue'
set ytics nomirror
set y2tics
set grid x mxtics
set style line 1 lt rgb "red" lw 3
set style line 2 lt rgb "blue" lw 3

# Output format
set terminal png enhanced size 1200,400
set output 'temp_log_plot.png'

# Plot!
plot 'temp_log.csv' using 1:2 axes x1y1 ls 1 with lines, \
     '' using 1:3 axes x1y2 ls 2 with lines
