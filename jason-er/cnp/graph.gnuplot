#!/opt/local/bin/gnuplot -persist
set datafile separator ","
#set title "Simulation Result"
set xlabel "number of concurrent CNP"
set ylabel "execution time (ms)"
set key top left
set term pdfcairo
set output "jason-er-time.pdf"
plot "data-er.csv" title "JasonER" smooth sbezier,\
     "data-j.csv"  title "Jason"   smooth sbezier

# smooth option sbezier csplines
