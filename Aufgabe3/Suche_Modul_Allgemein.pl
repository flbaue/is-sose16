% Das Programm wird mit solve(depth), solve(breadth) oder solve(informed) aufgerufen. a, astar, greedy, hill_climbing, hill_climbing_bt
solve(Strategy):-
  start_description(StartState),
  solve((start,StartState,_),Strategy).

solve(StartNode,Strategy) :-
  start_node(StartNode),
  search([[StartNode]],Strategy,Path),
  reverse(Path,Path_in_correct_order),
  write_solution(Path_in_correct_order),
  length(Path_in_correct_order,L),
  writeln(L).

% Abbruchbedingung: Wenn ein Zielzustand erreicht ist, wird der aktuelle Pfad an den dritten Parameter �bertragen.
%FirstNode wird am Anfang des Pfades hinzugef�gt, danah wird gepr�ft ob das ziel erreicht wurde
search([[FirstNode|Predecessors]|_],_,[FirstNode|Predecessors]) :-
 % writeln('Ziel erreicht?'),
  goal_node(FirstNode),
  nl,write('SUCCESS'),nl,!.


search([[FirstNode|Predecessors]|RestPaths],Strategy,Solution) :-
 %ansi_format([bold,fg(cyan)], 'Firstnode ~w', [FirstNode]),nl,
 expand(FirstNode,Children),                                    % Nachfolge-Zust�nde berechnen
 %ansi_format([bold,fg(yellow)], "Expand: Children from Firstnode: ~w",[Children]),nl,
%write_actions(Children),
  generate_new_paths(Children,[FirstNode|Predecessors],NewPaths), % Nachfolge-Zust�nde einbauen: NewPaths ist eine LISTE von Pfaden
  insert_new_paths(Strategy,NewPaths,RestPaths,AllPaths),        % Neue Pfade einsortieren
  search(AllPaths,Strategy,Solution).

generate_new_paths(Children,Path,NewPaths):-
	%maplist(Pr�dikat, Fromlist, ToNewlist): Alle Zust�nde dem Path entlang werden in States eingef�gt
  maplist(get_state,Path,States),
 % ansi_format([bold,fg(green)], "maplist(get_state,Path,States): ~w",[States]),nl,
  generate_new_paths_help(Children,Path,States,NewPaths).


% Abbruchbedingung, wenn alle Kindzust�nde abgearbeitet sind.
generate_new_paths_help([],_,_,[]).


% Falls der Kindzustand bereits im Pfad vorhanden war, wird der gesamte Pfad verworfen, denn er w�rde nur in einem Zyklus enden.
%(Dies betrifft nicht die Fortsetzung des Pfades mit Geschwister-Kindern.)
%Es wird nicht �berpr�ft, ob der Kindzustand in einem anderen Pfad vorkommt, denn m�glicherweise ist dieser Weg der g�nstigere.
generate_new_paths_help([FirstChild|RestChildren],Path,States,RestNewPaths):-
  get_state(FirstChild,State),
  %wenn true, dann haben wir einen Zyklys gefunden
  state_member(State,States),!,
  generate_new_paths_help(RestChildren,Path,States,RestNewPaths).


% Ansonsten, also falls der Kindzustand noch nicht im Pfad vorhanden war, wird er als Nachfolge-Zustand eingebaut.
generate_new_paths_help([FirstChild|RestChildren],Path,States,[[FirstChild|Path]|RestNewPaths]):-
  generate_new_paths_help(RestChildren,Path,States,RestNewPaths).

get_state((_,State,_),State).

% Alle Strategien: Keine neuen Pfade vorhanden
insert_new_paths(Strategy,[],OldPaths,OldPaths):-!.
  %write_fail(Strategy,OldPaths),!.

% Tiefensuche
insert_new_paths(depth,NewPaths,OldPaths,AllPaths):-
  append(NewPaths,OldPaths,AllPaths).
  %write_action(NewPaths).

% Breitensuche
insert_new_paths(breadth,NewPaths,OldPaths,AllPaths):-
  append(OldPaths,NewPaths,AllPaths).
  %write_next_state(AllPaths),
  %write_action(AllPaths).

% Informierte Suche: alt
/*insert_new_paths(informed,NewPaths,OldPaths,AllPaths):-
  eval_paths(NewPaths),
  insert_new_paths_informed(NewPaths,OldPaths,AllPaths),
  write_action(AllPaths),
  write_state(AllPaths).*/

% Optimistisches Bergsteigen
insert_new_paths(hill_climbing,NewPaths,_,[BestPath]):-
  eval_paths(greedy,NewPaths),
  insert_new_paths_informed(NewPaths,[],[BestPath|_]),
  BestPath = [A,B|_],!,
  %trace(),
  cheaper_hill(A,B),!.
  %notrace(),
  %nodebug().

 % write_action([BestPath]),
  %write_state([BestPath]).

% Optimistisches Bergsteigen mit Backtracking
insert_new_paths(hill_climbing_bt,NewPaths,OldPaths,AllPaths):-
  eval_paths(greedy,NewPaths),
  insert_new_paths_informed(NewPaths,[],SortedPaths),

  append(SortedPaths,OldPaths,AllPaths),
  SortedPaths = [BestPath|_],
  BestPath = [A,B|_],
  %trace(),
  cheaper_hill(A,B).
  %notrace(),
  %nodebug(),

 % write_action(SortedPaths),
  %write_state(SortedPaths).

% Informierte Suche: A, A*, Gierige Bestensuche
insert_new_paths(Suchverfahren,NewPaths,OldPaths,AllPaths):-
  eval_paths(Suchverfahren,NewPaths),
  insert_new_paths_informed(NewPaths,OldPaths,AllPaths).
%  write_action(AllPaths),
%  write_state(AllPaths).

write_solution(Path):-
  nl,write('SOLUTION:'),nl,
  write_actions(Path).

write_actions([]).

write_actions([(Action,_,_)|Rest]):-
  write('Action: '),write(Action),nl,
  write_actions(Rest).

%hiermit werden alle Zust�nde und ggf. Heuristiken ausgegeben
%write_actions(Solve):-
%ansi_format([bold,fg(red)], "L�sung: ~w",[Solve]),nl.

%%% Strategie:
write_action([[(Action,_)|_]|_]):-
  nl,write('Action: '),write(Action),nl.

write_next_state([[_,(_,State)|_]|_]):-
  nl,write('Go on with: '),write(State),nl.

write_state([[(_,State)|_]|_]):-
  write('New State: '),write(State),nl.

write_fail(depth,[[(_,State)|_]|_]):-
  nl,write('FAIL, go on with: '),write(State),nl.

write_fail(_,_):-  nl,write('FAIL').
