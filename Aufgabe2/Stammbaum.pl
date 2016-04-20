mann(nils). /*p3*/
mann(kurt). /*p1*/
mann(sam). /*p6*/
mann(otto). /*p8*/
mann(flo). /*p10*/

frau(nela). /*p4*/
frau(hanna). /*p2*/
frau(lena). /*p5*/
frau(lena2). /*p5*/
frau(linh). /*p9*/
frau(sonja). /*p7*/

kind(kurt,nils).
kind(kurt,nela).
kind(hanna,nils).
kind(hanna,nela).
kind(lena,nela).
kind(lena,sam).
kind(lena2,nela).
kind(lena2,sam).

kind(nils,otto).
kind(nils,linh).
kind(sonja,linh).
kind(sonja,otto).
kind(flo,sonja).

geschwister(X,Y):- kind(X,A), kind(Y,A), kind(X,B), kind(Y,B), X\==Y, A\==B.
bruder(X,Y):- mann(X), geschwister(X,Y).
schwester(X,Y):- frau(X), geschwister(X,Y).
halbschwester(X,Y):- kind(X,A), kind(Y,A), kind(X,B), kind(Y,C), B\==C, A\==B, A\==C, not(mann(X)).
cousine(X,Y):- frau(X), kind(X,A), kind(Y,B), geschwister(A,B).
cousin(X,Y):- mann(X), kind(X,A), kind(Y,B), geschwister(A,B).
nichte(X,Y):- frau(X), kind(X,A), geschwister(A,Y).
neffe(X,Y):- mann(X), kind(X,A), geschwister(A,Y).
vater(X,Y):- kind(Y,X), mann(X).
mutter(X,Y):- kind(Y,X), frau(X).
tochter(X,Y):- frau(X), kind(X,Y).
sohn(X,Y):- mann(X), kind(X,Y).
