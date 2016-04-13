/*
s(X,Z):- np(X,Y), vp(Y,Z).
np(X,Z):- pn(X,Z).
np(X,Z):- det(X,Y), n(Y,Z).
vp(X,Z):- v(X,Z).
vp(X,Z):- v(X,Y), np(Y,Z).

pn([john|Rest], Rest).
pn([mary|Rest], Rest).

n([man|Rest], Rest).
n([woman|Rest], Rest).
n([dog|Rest], Rest).
n([animals|Rest], Rest).
n([bird|Rest], Rest).
n([apple|Rest], Rest).
v([sings|Rest], Rest).
v([eats|Rest], Rest).
v([bites|Rest], Rest).
v([loves|Rest], Rest).
det([the|Rest], Rest).
*/

s --> np, vp.
np --> pn.
np --> det, n.
vp --> v.
vp --> v, np.

pn --> [X], {lex(X,pn)}.
n --> [X], {lex(X,n)}.
v --> [X], {lex(X,v)}.
det --> [X], {lex(X,det)}.

lex(bob,pn).
lex(man,n).
lex(dog,n).
lex(bites,v).
lex(the,det).
