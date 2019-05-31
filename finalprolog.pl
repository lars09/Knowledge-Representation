
:- use_module(library(pce)).

window_size(400, 400).

draw_square :-
  window_size(MaxX, MaxY),
  new(Window, picture('My window')),
  send(Window, size, size(MaxX, MaxY)),
  send(Window, open),
  draw_lines(Window),
  C1X is MaxX div 2 + 59,
  C1Y is MaxY div 2 - 20,
  draw_image(Window, C1X, C1Y, _),
  draw_lines(Window),
  C2X is MaxX div 2 + 109,
  C2Y is MaxY div 2 - 20,
  draw_image(Window, C2X, C2Y, _),
  draw_lines(Window),
  C3X is MaxX div 2 + 159,
  C3Y is MaxY div 2 - 20,
  draw_image(Window, C3X, C3Y, _),
  draw_lines(Window),
  C4X is MaxX div 2 + 59,
  C4Y is MaxY div 2 + 20,
  draw_image(Window, C4X, C4Y, _),
  draw_lines(Window),
  C5X is MaxX div 2 + 109,
  C5Y is MaxY div 2 + 20,
  draw_image(Window, C5X, C5Y, _),
  draw_lines(Window),
  C6X is MaxX div 2 + 159,
  C6Y is MaxY div 2 + 20,
  draw_image(Window, C6X, C6Y, _),
  draw_lines(Window),
  C7X is MaxX div 2 - 91,
  C7Y is MaxY div 2 - 20,
  draw_image(Window, C7X, C7Y, _),
  draw_lines(Window),
  C8X is MaxX div 2 - 141,
  C8Y is MaxY div 2 - 20,
  draw_image(Window, C8X, C8Y, _),
  draw_lines(Window),
  C9X is MaxX div 2 - 191,
  C9Y is MaxY div 2 - 20,
  draw_image(Window, C9X, C9Y, _),
  draw_lines(Window),
  C10X is MaxX div 2 - 91,
  C10Y is MaxY div 2 + 20,
  draw_image(Window, C10X, C10Y, _),
  draw_lines(Window),
  C11X is MaxX div 2 - 141,
  C11Y is MaxY div 2 + 20,
  draw_image(Window, C11X, C11Y, _),
  draw_lines(Window),
  C12X is MaxX div 2 - 191,
  C12Y is MaxY div 2 + 20,
  draw_image(Window, C12X, C12Y, _).
  
  
  
draw_lines(Window) :-
  window_size(MaxX, MaxY),
  X11 is MaxX div 2 + 50,
  Y11 is MaxY,
  X12 is X11, Y12 is 0,
  
  send(Window, display, new(Pa, path)),
        (
	      send(Pa, append, point(X11, Y11)),
          send(Pa, append, point(X12, Y12))
	   ),
  X21 is MaxX div 2 - 50, Y21 is MaxY,
  X22 is X21, Y22 is 0,
  send(Window, display, new(Pa2, path)),
        (
	      send(Pa2, append, point(X21, Y21)),
          send(Pa2, append, point(X22, Y22))
	   ).
	   
 draw_image(Window, X, Y, BitMap):-
       send(Window, display,
	     new(BitMap, bitmap('32x32/cannibal.xpm')), point(X,Y)).
		 
 draw_image(Window, X, Y, BitMap):-
       send(Window, display,
	     new(BitMap, bitmap('32x32/baby.xpm')), point(X,Y)).


% Cannibals and Missionaires Game

% 1. State Representation
% state(+MissionairesRight, +CannibalsRight, +BoatSide)

% 1. Only two people maximum in the boat and 1 people minimum
% 2. No more Cannibals than Missionaires at any side

% Initial State
state(3, 3, right).

% Final State
state(0, 0, _).

% 2. Movements
% People to the left

mov( move(M, C, left), state(MR, CR, right), state(NMR, NCR, left)):- 
 move(M,C,left),
 M =< MR, C =< CR, % move if we have people 
 NMR is MR - M, NCR is CR - C, % new people to the right
 \+ not_valid(NMR, NCR).

mov( move(M,C, right), state(MR, CR, left), state(NMR, NCR, right)):-
 move(M, C, right),
 ML is 3 - MR, CL is 3 - CR, % initial people to the left
 M =< ML, C =< CL, % enough people to the left to move
 NMR is MR + M, NCR is CR + C, % new people to the right
 \+ not_valid(NMR, NCR).

move(0, 1, _).
move(1, 0, _).
move(1, 1, _). 
move(2, 0, _). 
move(0, 2, _). 

not_valid(1,2).
not_valid(2,3).
not_valid(1,3).
not_valid(2,1).
not_valid(2,0).

path(Ini, Ini, _ , []).
path(Ini, Fin, Visited, [move(M,C,Side)|Path]):-
  mov( move(M, C, Side), Ini, Temp),
  \+ member(Temp, Visited),
  path(Temp, Fin, [Temp|Visited], Path).

% posRight(RX1, RX2, RX3). 
xPosRight(59, 109, 159). % MaxX div 2 + 59
yPosMis(20). % MaxY div 2 - 20
yPosCan(20). % MaxY div 2 + 20
xPosLeft(91,141,191).

% move(Mov(M,C,Dir), MisPosLeft, MisPosRight, CanPosLefr, CanPosRight).

move(Mov(M,C,left), MisPosLeft, MisPosRight, CanPosLefr, CanPosRight).
  left(L2, M),
  append(L1, L2, MisPosLeft),

  % Move = mov(0,1, left)
  % MisPosRight = [point(X,Y), point(X,Y), point(X,Y)]
  % MisPosLeft  ) 0 []
  % CanPosRight = [point(X,Y), point(X,Y), point(X,Y)]
  % CanPosLeft = []
		 