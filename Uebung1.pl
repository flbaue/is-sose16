likes(frank,Food):- italian(Food).
likes(frank,Food):- indian(Food),mild(Food).

likes(anna,Food):- indian(Food).
likes(anna,hamburger).

likes(kurt,pizza).
likes(kurt,Food):- likes(anna,Food).

italian(pizza).
italian(spaghetti).

indian(dahl).
indian(curry).

mild(dahl).
hot(curry).


unlist([F,P1,P2]):- solve(F,P1,P2, X), call(F,P1,X).

solve(F,P1,P2,X):- (var(P1), call(F,P1,P2),! , X = P1; var(P2), call(F,P1,P2),! , X = P2; call(F,P1,P2), !).
solve(_,[F,P1,P2],_, X):- solve(F,P1,P2, X).
solve(_,_,[F,P1,P2], X):- solve(F,P1,P2, X).



start([F,P1,P2]):- c(F,P1,P2).

c(F,P1,P2):- call(F,P1,P2).
c(F1,[F2,P21,P22],P12):- c(F2,P21,P22),!, (c(F1,P21,P12); c(F1,P22,P12)).
c(F1,P12,[F2,P21,P22]):- c(F2,P21,P22),!, (c(F1,P12,P21); c(F1,P12,P22)).
