% Die Schnittstelle umfasst
%   start_description	;Beschreibung des Startzustands
%   start_node          ;Test, ob es sich um einen Startknoten handelt
%   goal_node           ;Test, ob es sich um einen Zielknoten handelt
%   state_member        ;Test, ob eine Zustandsbeschreibung in einer Liste
%                        von Zustandsbeschreibungen enthalten ist
%   expand              ;Berechnung der Kind-Zustandsbeschreibungen
%   eval-path		;Bewertung eines Pfades

%-----mit 6 Blöcken---------------------------------------------------
start_description([
  b(b1), b(b2), b(b3), b(b4), b(b5), b(b6),
  on(t,b2),
  on(t,b3),
  on(t,b4),
  on(t,b1),
  on(b4,b6),
  on(b6,b5),
  c(b1),
  c(b2),
  c(b3),
  c(b5),
  he]).

goal_description([
  b(b1), b(b2), b(b3), b(b4), b(b5), b(b6),
  on(t,b2),
  on(t,b3),
  on(t,b4),
  on(t,b6),
  on(b2,b1),
  on(b1,b5),
  c(b4),
  c(b3),
  c(b5),
  c(b6),
  he]).
%------------------------------------------------------------------

start_node((start,_,_)).

goal_node((_,State,_)):-
 %1. "Zielbedingungen einlesen"
	goal_description(Ziel),
  %2. "Zustand gegen Zielbedingungen testen".
	%state_member(State,[Ziel]).
  mysubset(Ziel,State).

% Aufgrund der Komplexit�t der Zustandsbeschreibungen kann state_member nicht auf
% das Standardpr�dikat member zur�ckgef�hrt werden.
state_member(_,[]):- !,fail.

state_member(State,[FirstState|_]):-
  %3. "Test, ob State bereits durch FirstState beschrieben war. Tipp: Eine L�sungsm�glichkeit besteht in der Verwendung einer Mengenoperation, z.B. subtract"  ,!.
  subtract(State,FirstState,[]),!.

%Es ist sichergestellt, dass die beiden ersten Klauseln nicht zutreffen.
state_member(State,[_|RestStates]):-
 %4. "rekursiver Aufruf".
	state_member(State,RestStates).

%state_member(State,[FirstState|_]):-
  %mysubset(State,FirstState).

%eval_path([(_,State,Value)|RestPath]):-
% eval_state(State, Value). %5. "Rest des Literals bzw. der Klausel"
  %6. "Value berechnen".

eval_path(Suchverfahren,Path):-
  length(Path,G),
  eval_state(Suchverfahren,Path,G).

eval_state(a,[(_,State,Value)|_],G) :-
  heuristik(wrong_pos,State,Heuristik),
  Value is Heuristik + G.

eval_state(astar,[(_,State,Value)|_],G) :-
  heuristik(wrong_pos,State,Heuristik),
  Value is Heuristik + G.

eval_state(greedy,[(_,State,Heuristik)|_],_) :-
  heuristik(wrong_pos,State,Heuristik).

heuristik(wrong_pos,State,Value) :-
	goal_description(Ziel),
	subtract(Ziel,State,Diffmenge),%Diffmenge = Ziel\State

  % 1 wenn die hand belegt ist, sonst 0.
  isHandFilled(Diffmenge,H),

  % 1 für jeden block der auf dem Tisch steht und noch nicht erfüllt wurde,
  % plus der Anzahl aller blöcke die oben drauf sind.
  countOnTable(Diffmenge, Count),
  Value is H + Count.
	%length(Diffmenge,Value).

heuristik(wrong_pos_astar,State,Value) :-
  goal_description(Ziel),
  subtract(Ziel,State,Diffmenge),%Diffmenge = Ziel\State
  length(Diffmenge,Diffmengelen),
  Value is ceiling(Diffmengelen/3).%aufrunden

isHandFilled(M,0):- mysubset([he],M).
isHandFilled(_,1).


countOnTable([],0).
countOnTable([on(t,X)|R],C):- countAbove(R,X,C3), countOnTable(R,C2),  C is C2 + C3 + 1.
countOnTable([_|R],C):- countOnTable(R,C).


countAbove([],_,0).
countAbove(M,X,0):- mysubset([c(X)],M).
countAbove(M,X,C):- mysubset([on(X,Y)],M), countAbove(M,Y,C2), C is 1 + C2.


htest():- trace(), countOnTable([on(t,b2),on(b2,b1),on(b1,b5),c(b5)],C), writeln(C), notrace(), nodebug().

% Hilfskonstrukt, weil das PROLOG "subset" nicht die Unifikation von Listenelementen
% durchf�hrt, wenn Variablen enthalten sind. "member" unifiziert hingegen.
mysubset([],_).
mysubset([H|T],List):-
  member(H,List),
  mysubset(T,List).


expand_help(State,Name,NewState):-
  %7. "Action suchen"
  action(Name, Con, Del, Add),%Name wird belegt
  %8."Conditions testen"
  mysubset(Con,State),
  %9. "Del-List umsetzen": Lösche alle Elemente in Del die in State enthalten sind
	%hier: Diffmenge = State\Del
  subtract(State, Del, Diffmenge),
  %10."Add-List umsetzen".
  union(Diffmenge, Add, NewState).%NewState wird belegt

%Result ist hier eine Liste, z.B.
%[(put_on_table(b1),[b(b1),b(b2),b(b3),on(t,b3),c(b2),on(b3,b2),he,c(b1),on(t,b1)],_G9852),
%(put_on(b2,b1),[b(b1),b(b2),b(b3),on(t,b3),on(b3,b2),he,c(b1),on(b2,b1)],_G9800)].
expand((_,State,_),Result):-
  findall((Name,NewState,_),expand_help(State,Name,NewState),Result).

action(pick_up(X), %Action
       [he, c(X), on(t,X)],%Con
       [he, c(X), on(t,X)],%Del
       [ho(X)]).%Add

action(pick_up(X),
       [he, c(X), on(Y,X), b(Y)],
       [he, c(X), on(Y,X)],
       [ho(X), c(Y)]).

action(put_on_table(X),
       [ho(X)],
       [ho(X)],
       [he, c(X), on(t,X)]).

action(put_on(Y,X),
       [ho(X), c(Y)],
       [ho(X), c(Y)],
       [he, c(X), on(Y,X)]).
