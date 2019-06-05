:- use_module(library(pce)).



window_size(400, 400).



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

  

  

draw_square(Window) :-

  new(Window, picture('Missionaires and Cannibals')),

  send(Window, size, size(400,400)),

  send(Window, open),

  draw_lines(Window).

  

draw_lines(Window):- 

  window_size(MaxX, MaxY),

  X11 is (MaxX div 2 + 50),

  Y11 is MaxY,

  X12 is X11, Y12 is 0,

  send(Window, display, new(Pa, path)),

        (

	      send(Pa, append, point(X11, Y11)),

          send(Pa, append, point(X12, Y12))

		),

  X21 is (MaxX div 2 - 50), Y21 is MaxY,

  X22 is X21, Y22 is 0,  

  send(Window, display, new(Pa2, path)),

        (

	      send(Pa2, append, point(X21, Y21)),

          send(Pa2, append, point(X22, Y22))

		).  

 

% 

% path(state(3,3,right), state(0,0,_), [], P), write(P).

% P = [move(0,1,left),move(0,1,right),move(1,1,left),move(1,0,right),move(0,2,left),move(0,1,right),move(2,0,left),move(1,1,right),move(2,0,left),move(0,1,right),move(0,2,left),move(0,1,right),move(0,2,left)]



misPos([point(9,180), point(59, 180), point(109, 180), point(259,180), point(309,180), point(359, 180)]).

canPos([point(9,220), point(59, 220), point(109, 220), point(259,220), point(309, 220), point(359, 220)]).

  

rotateLeft(List, 0, List).  

rotateLeft([Head|Tail], N, R):- N > 0, N2 is N-1,

  append(Tail, [Head], L2),

  rotateLeft(L2, N2, R).



rotateRight(List, 0, List).    

rotateRight(List, N, R):- N > 0, N2 is N-1,

  append(L1, [Last], List),

  rotateRight([Last|L1], N2, R).

  

moveGraphic(_, [], _).

  

moveGraphic(Window, state(MisGraphState, CanGraphState), [move(Mis, Can, left)| Tail], ElementsList):-

  rotateLeft(MisGraphState, Mis, NewMisGraphState),

  rotateLeft(CanGraphState, Can, NewCanGraphState),

  % Delete elements

  deleteElements(ElementsList),

  % Paint new State

  misPos(MisPos), canPos(CanPos),

  paintState(state(NewMisGraphState, NewCanGraphState), MisPos, CanPos, Window, _),  

  % Delay time

  sleep(1),

  % write(state(NewMisGraphState, NewCanGraphState)),

  % write(nl),

  moveGraphic(Window, state(NewMisGraphState, NewCanGraphState), Tail).

  

moveGraphic(Window, state(MisGraphState, CanGraphState), [move(Mis, Can, right)| Tail], ElementsList):-

  rotateRight(MisGraphState, Mis, NewMisGraphState),

  rotateRight(CanGraphState, Can, NewCanGraphState),

  % Delete elements

  deleteElements(ElementsList),

  % Paint new State

  misPos(MisPos), canPos(CanPos),

  paintState(state(NewMisGraphState, NewCanGraphState), MisPos, CanPos, Window, NewElements),

  % Delay time

  sleep(1),

  % write(state(NewMisGraphState, NewCanGraphState)),

  % write(nl),

  moveGraphic(Window, state(NewMisGraphState, NewCanGraphState), Tail, NewElements).   



solution :-  path(state(3,3,right), state(0,0,_), [], P), draw_square(Window), moveGraphic(Window, state([0,0,0,1,1,1], [0,0,0,1,1,1]), P, []). 



deleteElements([]).

deleteElements([Head|Tail]):-

  free(Head),

  deleteElements(Tail).



paintState(state([], []), _, _, _, []).

paintState(state([HeadMis|TailMis], [HeadCan|TailCan]), 

  [HeadPosMis|TailPosMis], [HeadPosCan|TailPosCan], Window, 

  [BitmapMis, BitmapCan|BitmapList]):-  

  drawMis(Window, HeadMis, HeadPosMis, BitmapMis),

  drawCan(Window, HeadCan, HeadPosCan, BitmapCan),

  paintState(state(TailMis, TailCan), TailPosMis, TailPosCan, Window, BitmapList).

  

  

paintOneState :- draw_square(Window), 

  misPos(MisPos), canPos(CanPos),

  paintState(state([0,0,0,1,1,1], [0,0,0,1,1,1]), MisPos, CanPos, Window, _).  



drawCan(_, 0, _, _).

drawCan(Window, 1, point(X, Y), Bitmap1):- 

        send(Window, display,

          new(Bitmap1, bitmap('32x32/cannibal.xpm')), point(X,Y)).

		  

drawMis(_, 0, _, _).		  

drawMis(Window, 1, point(X, Y), Bitmap1):- 

        send(Window, display,

          new(Bitmap1, bitmap('32x32/angel.xpm')), point(X,Y)).