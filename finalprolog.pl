
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
  draw_image(Window, C6X, C6Y, _).
  
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
	     new(BitMap, bitmap('32x32/books.xpm')), point(X,Y)).
		 
		 