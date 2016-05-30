%consult('Suche.pl')
:- use_module(library(lists)).

:- consult('Suche_Modul_Allgemein.pl').
:- consult('Suche_Modul_Planung_Vorlage.pl').
:- consult('Suche_Modul_Informierte_Suche.pl').

solve():-	ansi_format([bold,fg(red)], 'Tiefensuche ~w', [':']),nl,solve(breadth),
			ansi_format([bold,fg(red)], 'Breitensuche ~w', [':']),nl,solve(depth),
			ansi_format([bold,fg(red)], 'A-Alg ~w', [':']),nl,writeln(":"),solve(a),
			ansi_format([bold,fg(red)], 'A*-Alg ~w', [':']),nl,solve(astar),
			ansi_format([bold,fg(red)], 'Gierige Breitensuche ~w', [':']),nl,solve(greedy),
			ansi_format([bold,fg(red)], 'opt. Bergsteigen ~w', [':']),nl,solve(hill_climbing), 
			ansi_format([bold,fg(red)], 'opt. Bergsteigen mit BT ~w', [':']),nl,solve(hill_climbing_bt).

%%% Spezieller Teil: Planung
%:- consult('Suche_Modul_Planung.pl').
