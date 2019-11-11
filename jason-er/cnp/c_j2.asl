// alternative implementation without .wait(<condition>), see plan for !bid

/* Initial beliefs and rules */

all_proposals_received(CNPId, NP)                // NP: number of participants
  :- .count(propose(CNPId,_)[source(_)], NO) &   // NO: number of proposes received
     .count(refuse(CNPId)[source(_)], NR) &      // NR: number of refusals received
     NP = NO + NR.

/* Initial goals */

!run.
!register.
+!register <- .df_register(initiator).

{ include("n.asl") } // the numnber of CNP
/* Plans */
+!run : n(N)
   <- //.print("starting ",N," CNPs");
      .wait(500);  // wait participants introduction
      for ( .range(I,1,N)) {
        !!cnp(I ,fix(computer));
      }
   .

+jag_sleeping : n(N) & .count( done(_), N )
   <- .stopMAS.

+!cnp(Id,Task)
  <- !call(Id,Task,LP);
     !bid(Id,LP);
     !winner(Id,LO,WAg);
     !result(Id,LO,WAg);
     +done(Id).
+!call(Id,Task,LP)
  <- .df_search("participant",LP);
     //.print("Sending CFP to ",LP);
     .send(LP,tell,cfp(Id,Task)).
+!bid(Id,LP) // the deadline of the CNP is now + 4 seconds (or all proposals received)
  <- .wait(all_proposals_received(Id,.length(LP)), 4000, _).
+!winner(Id,LO,WAg)
  :  .findall(offer(O,A),propose(CNPId,O)[source(A)],LO) & LO \== [] // there is an offer
  <- //.print("Offers are ",LO);
     .min(LO,offer(WOf,WAg)); // the first offer is the best
     //.print("Winner is ",WAg," with ",WOf);
  .
+!winner(_,_,nowinner). // no offer case

+!result(Id,LO,WAg)
   <- for( .member( offer(_,Ag), LO) ) {
         if (Ag == WAg) {
           .send(Ag,tell,accept_proposal(Id));
         } else {
           .send(Ag,tell,reject_proposal(Id));
         }
      }.
