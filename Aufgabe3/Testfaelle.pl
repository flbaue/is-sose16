%------hill_climbing scheitert, alle anderen finden eine Lösung----
start_description([
  b(b1),
  b(b2),
  b(b3),
  on(t,b1),
  on(t,b3),
  on(b1,b2),
  c(b2),
  c(b3),
  he]).

goal_description([
  b(b1),
  b(b2),
  b(b3),
  on(t,b1),
  on(b1,b3),
  on(b3,b2),
  c(b2),
  he]).
%------------------------------------------------------------------

%-----mit Block4---------------------------------------------------
start_description([
  b(b1),
  b(b2),
  b(b3),
  b(b4),
  on(t,b2),
  on(t,b3),
  on(b2,b1),
  on(t,b4),
  c(b1),
  c(b3),
  c(b4),
  he]).

goal_description([
  b(b1),
  b(b2),
  b(b3),
  b(b4),
  on(b4,b2),
  on(t,b3),
  on(t,b1),
  on(b1,b4),
  c(b3),
  c(b2),
  he]).
%------------------------------------------------------------------

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

%----ohne Block4-------------------------
start_description([
  b(b1),
  b(b2),
  b(b3),
  on(t,b2),
  on(t,b3),
  on(b2,b1),
  c(b1),
  c(b3),
  he]).

goal_description([
  b(b1),
  b(b2),
  b(b3),
  on(t,b3),
  on(t,b1),
  on(b1,b2),
  c(b3),
  c(b2),
  he]).
%--------------------------------------
