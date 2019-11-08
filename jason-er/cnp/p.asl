// gets the price for the product,
// a random value between 100 and 110.
price(_Service,X) :- .random(R) & X = (10*R)+100.

!register.
+!register <- .df_register("participant");
              .df_subscribe("initiator").

// answer to Call For Proposal
+cfp(CNPId,Task)[source(A)]
    : provider(A,"initiator") & price(Task,Offer)
   <- .send(A,tell,propose(CNPId,Offer)).
