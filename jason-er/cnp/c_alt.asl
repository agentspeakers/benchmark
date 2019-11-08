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
      .wait(1000);  // wait participants introduction
      for ( .range(I,1,N)) {
        !!cnp(I ,fix(computer));
      }
   .

+jag_sleeping : not .intend(run) & not .intend(cnp(_,_))
   <- .stopMAS.

+!cnp(Id,Task) {
    <- !call(LP); !bids(LP); !winner(LO,W); !result(LO,W); -done(Id).

    +!call(LP)
       <- .df_search("participant",LP);
          .send(LP,tell,cfp(Id,Task)).

    +!bids(LP) : NP = .length(LP) <: done(Id) {
       <- .wait(4000); +done(Id).
       +propose(Id,_) : all_proposals_received(Id, NP) <- +done(Id).
       +refuse(Id)    : all_proposals_received(Id, NP) <- +done(Id).
    }

    +!winner(LO,WAg)
        : .findall(offer(O,A),propose(Id,O)[source(A)],LO) & LO \== []
       <- //.print("Offers are for ",Task," are ",LO);
          .min(LO,offer(WOf,WAg)); // sort offers, the first is the best
          //.print("Winner for ",Id," is ",WAg," with ",WOf)
      .
    +!winner([],nowinner)
       <- .print("CNP ",Id," with no offer!").

    +!result(LO,WAg)
       <- for( .member( offer(_,Ag), LO) ) {
             if (Ag == WAg) {
               .send(Ag,tell,accept_proposal(Id));
             } else {
               .send(Ag,tell,reject_proposal(Id));
             }
          }.
}
