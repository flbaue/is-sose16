:- consult('./Praktikum1.pl').
:- consult('./readsentence.pl').

start() :- writeln("Frage:"), read_sentence(X), s(X,[]).

s --> interrogativpronomen, vp(Numerus, Funktion) , pp(Name), [?], {call(Funktion, X, Name), writeln(X), Numerus == singular}.
s --> vp(singular, Name1), np(_, Funktion), pp(Name2), [?], {call(Funktion, Name1, Name2)}.
s --> vp(singular, Name),  np(_, Funktion), [?], {call(Funktion, Name)}.
s --> vp(singular, N1), {writeln(N1)} ,np(_, F1), {writeln(F1)}, pp(F2), {writeln(F2)}, pp(N2), {writeln(N2)}, [?], {call(F1, N1, X),  writeln(X), call(F2, X, N2)}.

vp(Numerus, X) --> verb(Numerus), np(Numerus, X).

pp(X) --> praeposition, np(_, X).

np(Numerus, Funktion) --> artikel(Numerus), nomen(Numerus, Funktion).
np(Numerus, Funktion) --> artikelUnbestimmt(Numerus), nomen(Numerus, Funktion).
np(singular, Name) --> name(Name).


interrogativpronomen --> [X], {lex(X, interrogativpronomen)}.
verb(Numerus) --> [X], {lex(X, verb, Numerus)}.
artikel(Numerus) --> [X], {lex(X, artikel, Numerus)}.
artikelUnbestimmt(Numerus) --> [X], {lex(X, artikelUnbestimmt, Numerus)}.
nomen(Numerus, Funktion) --> [X], {lex(X, nomen, Numerus, Funktion)}.
praeposition --> [X], {lex(X, praeposition)}.
name(X)--> [X], {lex(X, name)}.


lex(ist, verb, singular).
lex(sind, verb, plural).
lex(die, artikel, _).
lex(der, artikel, _).
lex(ein, artikelUnbestimmt, singular).
lex(eine, artikelUnbestimmt, singular).
lex(halbschwester, nomen, singular, halfsister).
lex(halbschwestern, nomen, plural, halfsister).
lex(bruder, nomen, singular, brother).
lex(brueder, nomen, plural, brother).
lex(schwester, nomen, singular, sister).
lex(schwestern, nomen, plural, sister).
lex(cousin, nomen, singular, cousin).
lex(cousins, nomen, plural, cousin).
lex(cousine, nomen, singular, cousine).
lex(cousinen, nomen, plural, cousin).
lex(vater, nomen, singular, vater).
lex(mutter, nomen, singular, mutter).
lex(kind, nomen, singular, child).
lex(mann, nomen, singular, male).
lex(frau, nomen, singular, female).
lex(tochter, nomen, singular, tochter).
lex(sohn, nomen, singular, sohn).
lex(wer, interrogativpronomen).
lex(von, praeposition).
lex(vom, praeposition). % eigentlich nur im Dativ
lex(Name, name) :- male(Name).
lex(Name, name) :- female(Name).
