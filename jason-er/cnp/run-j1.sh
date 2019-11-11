#!/bin/zsh
# run:
#          ./run-j1.sh 2> data-j1.csv
TIMEFMT=$'%*U'
for i in {1..150..5}
do
  echo "n($i)." | cat > n.asl
  for j in {1..5}
  do
    echo -n $i, >&2
    time java -cp ../libs/jason-2.5.jar jason.infra.centralised.RunCentralisedMAS cnp-j1.mas2j
  done
done
