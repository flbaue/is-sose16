:- consult('./Stammbaum.pl').
:- consult('./../readsentence.pl').
:- consult('Lexikon.pl').

test1 :-
	X = [wer, ist, der, bruder, von, hanna,?],
	write('Frage: '),writeln(X),
	write('Antwort: '),s(X,X,[]).

test2 :-
	X = [wer, ist, der, bruder, der, tochter, von, nils,?],nl,
	write('Frage: '),writeln(X),
	write('Antwort: '),s(X,X,[]).

test3 :-
	X = [wer, ist, die, mutter, des, bruders, von, hanna,?], nl,
	write('Frage: '),writeln(X),
	write('Antwort: '),s(X,X,[]).

test4 :-
	X = [ist ,nela ,die ,mutter ,des ,bruders ,von ,hanna,?],nl,
	write('Frage: '),writeln(X),
	write('Antwort: '),s(X,X,[]).

test5 :-
	X = [ist ,nela ,eine ,frau ,?],nl,
	write('Frage: '),writeln(X),
	write('Antwort: '), s(X,X,[]).

test6 :-
	X = [ist ,nela ,ein ,mann ,?],nl,
	write('Frage: '),writeln(X),
	write('Antwort: '), s(X,X,[]).

test7 :-
	X = [wer, sind, die, halbschwestern, des, bruders, von, hanna,?], nl,
	write('Frage: '),writeln(X),
	write('Antwort: '),s(X,X,[]).

test8 :-
	X = [wer, sind, die, halbschwestern, von, hanna,?], nl,
	write('Frage: '),writeln(X),
	write('Antwort: '),  s(X,X,[]).%trace(),





