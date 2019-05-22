
% Hanoi Tower Game

%   |      |      |
%   |      |      |
% -----  -----  -----
%   A      B      C
%

% hanoi(+Num, +A, +B, +C, -Result)
% it is true if Result unify with a list
% of movements needed to transport N discs
% from A to C using B as auxiliairy tower.
% The game have the restriction that is not
% possible to put a disc over other one that
% is a smaller disc. It is not possible to
% move more than one disc at the same time. 

% 1. Move n-1 discs from A to B using C as 
%    auxiliairy.
%
% 2. Move disc 1 from A to C.
%
% 3. Move n-1 disc from B to C using A as
%    auxiliairy tower.

hanoi(1, A, _, C, [move(A,C)]).

hanoi(N, A, B, C, R):-
  N2 is N-1, 
  hanoi(N2, A, C, B, R1), 
  hanoi(1, A, _, C, R2),
  hanoi(N2, B, A, C, R3),
  append([R1, R2, R3], R).
 
 
