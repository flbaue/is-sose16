:- consult('./Praktikum1.pl').
:- consult('./readsentence.pl').

s --> interrogativpronomen, vp(Numerus, Funktion) , pp(Name), [?], {call(Funktion, X, Name), writeln(X), Numerus == singular}.
s --> vp(singular, Name1), np(_, Funktion), pp(Name2), [?], {call(Funktion, Name1, Name2)}.

vp(Numerus, X) --> verb(Numerus), np(Numerus, X).

pp(X) --> praeposition, np(_, X).

np(Numerus, Funktion) --> artikel(Numerus), nomen(Numerus, Funktion).
np(singular, Name) --> name(Name).


interrogativpronomen --> [X], {lex(X, interrogativpronomen)}.
verb(Numerus) --> [X], {lex(X, verb, Numerus)}.
artikel(Numerus) --> [X], {lex(X, artikel, Numerus)}.
nomen(Numerus, Funktion) --> [X], {lex(X, nomen, Numerus, Funktion)}.
praeposition --> [X], {lex(X, praeposition)}.
name(X)--> [X], {lex(X, name)}.


lex(ist, verb, singular).
lex(sind, verb, plural).
lex(die, artikel, _).
lex(halbschwester, nomen, singular, halfsister).
lex(halbschwestern, nomen, plural, halfsister).
lex(wer, interrogativpronomen).
lex(von, praeposition).
lex(Name, name) :- male(Name).
lex(Name, name) :- female(Name).
