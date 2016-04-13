male(nils). /*p3*/
male(kurt). /*p1*/
male(sam). /*p6*/
male(otto). /*p8*/
male(flo). /*p10*/

female(nela). /*p4*/
female(hanna). /*p2*/
female(lena). /*p5*/
female(lena2). /*p5*/
female(linh). /*p9*/
female(sonja). /*p7*/

child(kurt,nils).
child(kurt,nela).
child(hanna,nils).
child(hanna,nela).
child(lena,nela).
child(lena,sam).
child(lena2,nela).
child(lena2,sam).

child(nils,otto).
child(nils,linh).
child(sonja,linh).
child(sonja,otto).
child(flo,sonja).

sibling(X,Y):- child(X,A), child(Y,A), child(X,B), child(Y,B), X\==Y, A\==B.
brother(X,Y):- male(X), sibling(X,Y).
sister(X,Y):- female(X), sibling(X,Y).
halfsister(X,Y):- child(X,A), child(Y,A), child(X,B), child(Y,C), B\==C, A\==B, A\==C, not(male(X)).
cousin(X,Y):- child(X,A), child(Y,B), sibling(A,B).
niece(X,Y):- child(X,A), sibling(A,Y).

/*sibling(X,Y) :- setof((X,Y), P^(child(X,P),child(Y,P), \+X=Y), Sibs), member((X,Y), Sibs), \+ (Y@<X, member((Y,X), Sibs)).*/

t --> [a],[?].
