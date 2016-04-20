:- consult('./Stammbaum.pl').
:- consult('./../readsentence.pl').

start() :- writeln("Frage:"), read_sentence(X), s(X, X, []).

% Ergänzungsfrage: Wer ist der Bruder von Hanna?
%s --> interrogativpronomen, vp(Numerus, Funktion) , pp(Name), [?], {call(Funktion, X, Name), writeln(X), Numerus == singular}.
s(X) --> interrogativpronomen, vp(Numerus, FunktionL) , pp(Name), [?], {c(FunktionL, A, Name), X = [_|R], delete([A|R], ?, Y),w(Y), Numerus == singular}.

% Entscheidungsfrage: Ist Nela die Mutter des Bruders von Hanna?
%s --> vp(singular, Name1), np(_, Funktion), pp(Name2), [?], {call(Funktion, Name1, Name2)}.
s(_) --> vp(singular, [Name1]), np_rec(_, FunktionL), pp(Name2), [?], {c(FunktionL, Name1, Name2)}.
%s --> vp(singular, N1),np(_, F1), pp(F2), pp(N2), [?], {call(F1, N1, X),  writeln(X), call(F2, X, N2)}.

% Entscheidungsfrage: Ist Kurt ein Mann?
s(_) --> vp(singular, [Name]),  np(_, Funktion), [?], {call(Funktion, Name)}.


% Antwortsatz schreiben
w([X|[]]):- write(X), write('.\n').
w([X|R]):- write(X), write(' '), w(R).

% Funktionsaufruf für Funktionslisten
c([F|[]], Name1, Name2):- call(F, Name1, Name2).
c([F|R], Name1, Name2):- call(F, Name1, X), c(R, X, Name2).

% VP (z.B. ist der Bruder)
%vp(Numerus, X) --> verb(Numerus), np(Numerus, X).
vp(Numerus, XL) --> verb(Numerus), np_rec(Numerus, XL).


pp(X) --> praeposition, np(_, X).


% Rekursive NP (z.B: die Mutter des Bruders)
np_rec(Numerus, Funktion) --> {Funktion = [F]}, np(Numerus, F).
np_rec(Numerus, Funktion) --> {Funktion = [F|FL]}, np(Numerus, F), np_rec(Numerus, FL).

np(Numerus, Funktion) --> artikel(Numerus), nomen(Numerus, Funktion).
np(Numerus, Funktion) --> artikelUnbestimmt(Numerus), nomen(Numerus, Funktion).
np(singular, Name)    --> name(Name).


interrogativpronomen        --> [X], {lex(X, interrogativpronomen)}.
verb(Numerus)               --> [X], {lex(X, verb, Numerus)}.
artikel(Numerus)            --> [X], {lex(X, artikel, Numerus)}.
artikelUnbestimmt(Numerus)  --> [X], {lex(X, artikelUnbestimmt, Numerus)}.
nomen(Numerus, Funktion)    --> [X], {lex(X, nomen, Numerus, Funktion)}.
praeposition                --> [X], {lex(X, praeposition)}.
name(X)                     --> [X], {lex(X, name)}.


lex(ist, verb, singular).
lex(sind, verb, plural).
lex(die, artikel, _).
lex(der, artikel, _).
lex(des, artikel, _).
lex(ein, artikelUnbestimmt, singular).
lex(eine, artikelUnbestimmt, singular).
lex(halbschwester, nomen, singular, halbschwester).
lex(halbschwestern, nomen, plural, halbschwester).
lex(bruder, nomen, singular, bruder).
lex(bruders, nomen, singular, bruder).
lex(brueder, nomen, plural, bruder).
lex(schwester, nomen, singular, schwester).
lex(schwestern, nomen, plural, schwester).
lex(cousin, nomen, singular, cousin).
lex(cousins, nomen, plural, cousin).
lex(cousine, nomen, singular, cousine).
lex(cousinen, nomen, plural, cousin).
lex(vater, nomen, singular, vater).
lex(vaters, nomen, singular, vater).
lex(mutter, nomen, singular, mutter).
lex(kind, nomen, singular, kind).
lex(kindes, nomen, singular, kind).
lex(mann, nomen, singular, mann).
lex(mannes, nomen, singular, mann).
lex(frau, nomen, singular, frau).
lex(tochter, nomen, singular, tochter).
lex(sohn, nomen, singular, sohn).
lex(sohnes, nomen, singular, sohn).
lex(wer, interrogativpronomen).
lex(von, praeposition).
lex(vom, praeposition). % eigentlich nur im Dativ
lex(Name, name) :- mann(Name).
lex(Name, name) :- frau(Name).
