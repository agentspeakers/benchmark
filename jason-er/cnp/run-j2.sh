#!/bin/zsh
# run:
#          ./run-j2.sh 2> data-j2.csv
TIMEFMT=$'%*U'
for i in {1..100..5}
do
  echo "n($i)." | cat > n.asl
  for j in {1..5}
  do
    echo -n $i, >&2
    time java -cp ../libs/jason-2.5.jar jason.infra.centralised.RunCentralisedMAS cnp-j2.mas2j
  done
done
