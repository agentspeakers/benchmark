#!/bin/zsh
# run:
#          ./run-j.sh 2> data-j.csv
TIMEFMT=$'%*U'
for i in {1..100}
do
  echo "n($i)." | cat > n.asl
  for j in {1..5}
  do
    echo -n $i, >&2
    time java -cp ../libs/jason-2.5.jar jason.infra.centralised.RunCentralisedMAS cnp-j.mas2j
  done
done
