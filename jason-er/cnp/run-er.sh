#!/bin/zsh
# run:
#          ./run-er.sh 2> data-er.csv
#
TIMEFMT=$'%*U'
for i in {1..100}
do
  echo "n($i)." | cat > n.asl
  for j in {1..5}
  do
    echo -n $i, >&2
    time java -cp ../libs/jason-er.jar jason.infra.centralised.RunCentralisedMAS cnp-er.mas2j
  done
done
