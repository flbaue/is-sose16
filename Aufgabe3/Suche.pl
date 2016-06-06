%consult('Suche.pl')
:- use_module(library(lists)).

:- consult('Suche_Modul_Allgemein.pl').
:- consult('Suche_Modul_Planung_Vorlage.pl').
:- consult('Suche_Modul_Informierte_Suche.pl').

solve():-	ansi_format([bold,fg(red)], 'Tiefensuche ~w', [':']),nl,time(solve(breadth)),
			ansi_format([bold,fg(red)], 'Breitensuche ~w', [':']),nl,time(solve(depth)),
			ansi_format([bold,fg(red)], 'A-Alg ~w', [':']),nl,time(solve(a)),
			ansi_format([bold,fg(red)], 'A*-Alg ~w', [':']),nl,time(solve(astar)),
			ansi_format([bold,fg(red)], 'Gierige Breitensuche ~w', [':']),nl,time(solve(greedy)),
			ansi_format([bold,fg(red)], 'opt. Bergsteigen ~w', [':']),nl,time(solve(hill_climbing)),
			ansi_format([bold,fg(red)], 'opt. Bergsteigen mit BT ~w', [':']),nl,time(solve(hill_climbing_bt)).

%%% Spezieller Teil: Planung
%:- consult('Suche_Modul_Planung.pl').
