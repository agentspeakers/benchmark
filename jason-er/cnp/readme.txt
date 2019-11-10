Experiment to evaluate JasonER vs Jason

n CNPs are run concurrently
CPU time is measured to finish the n CNPs (using time -U)

We have code (.asl) for
- p.asl, pn.asl, pr.asl: participant agents (the same for all cases)
- c_j.asl : Jason implementation of CNP initiator (based on code available in Jason > 2.0). Contains .wait(<expression>).
- c_j2.asl: Jason implementation of CNP initiator (based on code available in Jason < 2.0). Without .wait(<expression>).
- c_er.asl: JasonER version
- n.asl: the number of CNPs  (included in c*.asl)

There are 3 MAS application files:
- cnp-j.mas2j : that uses c_j.asl
- cnp-j2.mas2j: that uses c_j2.asl
- cnp-er.mas2j: that uses c_er.asl

Each MAS has 1 initiator, 11 participants

Scripts
- run*.sh are used to run MAS with different n values, collect CPU time, and store the results in csv files.
- graph.gnuplot is used to produce the graph with the results
