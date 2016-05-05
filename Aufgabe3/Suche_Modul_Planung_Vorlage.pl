% Die Schnittstelle umfasst
%   start_description	;Beschreibung des Startzustands
%   start_node          ;Test, ob es sich um einen Startknoten handelt
%   goal_node           ;Test, ob es sich um einen Zielknoten handelt
%   state_member        ;Test, ob eine Zustandsbeschreibung in einer Liste 
%                        von Zustandsbeschreibungen enthalten ist
%   expand              ;Berechnung der Kind-Zustandsbeschreibungen
%   eval-path		;Bewertung eines Pfades


start_description([
  b(b1),
  b(b2),
  b(b3),
  /*b(b4),  %mit Block4*/
  on(t,b2),
  on(t,b3),
  on(b2,b1),
 % on(t,b4), %mit Block4
  c(b1),
  c(b3),
  /*c(b4), %mit Block4*/
  he
  ]).

goal_description([
  b(b1),
  b(b2),
  b(b3),
  /*b(b4), %mit Block4*/
  on(b4,b2), %mit Block4
  on(t,b3),
  on(t,b1),
/* on(b1,b4), %mit Block4*/
 on(b1,b2), %ohne Block4
  c(b3),
  c(b2),
  he
  ]).

start_node((start,_,_)).

goal_node((_,State,_)):-
 %1. "Zielbedingungen einlesen"
	goal_description(Ziel),
  %2. "Zustand gegen Zielbedingungen testen".
	state_member(State,Ziel).

% Aufgrund der Komplexität der Zustandsbeschreibungen kann state_member nicht auf 
% das Standardprädikat member zurückgeführt werden. 
state_member(_,[]):- !,fail.

state_member(State,[FirstState|_]):-
  %3. "Test, ob State bereits durch FirstState beschrieben war. Tipp: Eine Lösungsmöglichkeit besteht in der Verwendung einer Mengenoperation, z.B. subtract"  ,!.  

%Es ist sichergestellt, dass die beiden ersten Klauseln nicht zutreffen.
state_member(State,[_|RestStates]):-  
 %4. "rekursiver Aufruf".
	state_member(State,RestStates).

eval_path([(_,State,Value)|RestPath]):-
  eval_state(State,RestPath), %5. "Rest des Literals bzw. der Klausel"
  %6. "Value berechnen".

  

action(pick_up(X),
       [he, c(X), on(t,X)],
       [he, c(X), on(t,X)],
       [ho(X)]).

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


% Hilfskonstrukt, weil das PROLOG "subset" nicht die Unifikation von Listenelementen 
% durchführt, wenn Variablen enthalten sind. "member" unifiziert hingegen.
mysubset([],_).
mysubset([H|T],List):-
  member(H,List),
  mysubset(T,List).


expand_help(State,Name,NewState):-
  %7. "Action suchen"

  %8."Conditions testen"

  %9. "Del-List umsetzen"

  %10."Add-List umsetzen".
  
expand((_,State,_),Result):-
  findall((Name,NewState,_),expand_help(State,Name,NewState),Result).

