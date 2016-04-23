:- consult('./Stammbaum.pl').
:- consult('./../readsentence.pl').

start() :- writeln("Frage:"), read_sentence(X), s(X, X, []).

% Ergänzungsfrage: Wer ist der Bruder von Hanna?
%s --> interrogativpronomen, vp(Numerus, Funktion) , pp(Name), [?], {call(Funktion, X, Name), writeln(X), Numerus == singular}.
s(X) --> interrogativpronomen, vp(Numerus, FunktionL, Name), [?], {c(FunktionL, A, Name), X = [_|R], delete([A|R], ?, Y),w(Y), Numerus == singular}.

% Entscheidungsfrage: Ist Nela die Mutter des Bruders von Hanna?
%s --> vp(singular, Name1), np(_, Funktion), pp(Name2), [?], {call(Funktion, Name1, Name2)}.
s(_) --> verb(singular), name(Name1), np_rec(_, FunktionL, Name2),  [?], {(var(Name2), !, FunktionL = [F|_], call(F, Name1); c(FunktionL, Name1, Name2))}.
%s --> vp(singular, N1),np(_, F1), pp(F2), pp(N2), [?], {call(F1, N1, X),  writeln(X), call(F2, X, N2)}.

% Entscheidungsfrage: Ist Kurt ein Mann?
s(_) --> verb(singular), name(Name),  np(_, Funktion, _), [?], {call(Funktion, Name)}.


% Antwortsatz schreiben
w([X|[]]):- write(X), write('.\n').
w([X|R]):- write(X), write(' '), w(R).

% Funktionsaufruf für Funktionslisten
c([F|[]], Name1, Name2):- call(F, Name1, Name2).
c([F|R], Name1, Name2):- call(F, Name1, X), c(R, X, Name2).

% VP (z.B. ist der Bruder)
%vp(Numerus, X) --> verb(Numerus), np(Numerus, X).
vp(Numerus, FL, Name) --> verb(Numerus), np_rec(Numerus, FL, Name).


pp(Name) --> praeposition(_), name(Name).


% Rekursive NP (z.B: die Mutter des Bruders)
np_rec(Numerus, Funktion, Name) --> {Funktion = [F]}, np(Numerus, F, Name).
np_rec(Numerus, Funktion, Name) --> {Funktion = [F|FL]}, np(Numerus, F, _), np_rec(Numerus, FL, Name).

np(Numerus, Funktion, _) --> artikel(Numerus, Fall), nomen(Numerus, Funktion, Fall).
np(Numerus, Funktion, _) --> artikelUnbestimmt(Numerus, Fall), nomen(Numerus, Funktion, Fall).
np(Numerus, Funktion, Name) --> artikel(Numerus, Fall), nomen(Numerus, Funktion, Fall), pp(Name).
np(Numerus, Funktion, Name) --> artikelUnbestimmt(Numerus, Fall), nomen(Numerus, Funktion, Fall), pp(Name).
np(singular, _, Name)    --> name(Name).


interrogativpronomen              --> [X], {lex(X, interrogativpronomen)}.
verb(Numerus)                     --> [X], {lex(X, verb, Numerus)}.
artikel(Numerus, Fall)            --> [X], {lex(X, artikel, Numerus, Fall)}.
artikelUnbestimmt(Numerus, Fall)  --> [X], {lex(X, artikelUnbestimmt, Numerus, Fall)}.
nomen(Numerus, Funktion, Fall)    --> [X], {lex(X, nomen, Numerus, Funktion, Fall)}.
praeposition(Fall)                --> [X], {lex(X, praeposition, Fall)}.
name(X)                           --> [X], {lex(X, name)}.


lex(ist, verb, singular).
lex(sind, verb, plural).
lex(von, praeposition, nogenetiv).
lex(vom, praeposition, nogenetiv). % eigentlich nur im Dativ
lex(die, artikel, _,nogenetiv).
lex(der, artikel, _, _).
lex(des, artikel, _,genetiv).
lex(ein, artikelUnbestimmt, singular, nogenetiv).
lex(eine, artikelUnbestimmt, singular, nogenetiv).
lex(halbschwester, nomen, singular, halbschwester,_).
lex(halbschwestern, nomen, plural, halbschwester,_).
lex(bruder, nomen, singular, bruder,_).
lex(bruders, nomen, singular, bruder,genetiv).
lex(brueder, nomen, plural, bruder,nogenetiv).
lex(schwester, nomen, singular, schwester,_).
lex(schwestern, nomen, plural, schwester, nogenetiv).
lex(cousin, nomen, singular, cousin, nogenetiv).
lex(cousins, nomen, plural, cousin, _).
lex(cousins, nomen, singular, cousin, genetiv).
lex(cousine, nomen, singular, cousin,_).
lex(cousinen, nomen, plural, cousin,_).
lex(vater, nomen, singular, vater,_).
lex(vaters, nomen, singular, vater,_).
lex(mutter, nomen, singular, mutter,_).
lex(kind, nomen, singular, kind,_).
lex(kindes, nomen, singular, kind,_).
lex(mann, nomen, singular, mann,_).
lex(mannes, nomen, singular, mann,_).
lex(frau, nomen, singular, frau,_).
lex(tochter, nomen, singular, tochter,_).
lex(sohn, nomen, singular, sohn,_).
lex(sohnes, nomen, singular, sohn,_).
lex(wer, interrogativpronomen).
lex(Name, name) :- mann(Name).
lex(Name, name) :- frau(Name).
