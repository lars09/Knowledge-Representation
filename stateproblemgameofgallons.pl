
% State Problem Game of Gallons
%
% We have to obtain exactly 4 gallons using
% two bottles one with 5 gallons and other with 3 gallons.
% try to disarm the bomb.



% state(Gallons5, Gallons3)
% Gallons5 represent the number of gallons inside 5 gallons bottle.
% Gallons3 represent the number of gallons inside 3 gallons bottle.

% Initial state:
% state(0,0).

% Final state:
% state(4, _).

% Creating the movements

% 1. Fill 5 gallons bottle.
% 2. Fill 3 gallons bottle.
% 3. Put 5 gallons in 3 gallons bottle.
% 4. Put 3 gallons in 5 gallons bottle.
% 5. Empty 5 gallons bottle.
% 6. Empty 3 gallons bottle.

% mov(+MovementName, +StateBefore, +StateAfter)

% 1. Fill 5 gallons bottle.
mov(fill5, state(_, G3), state(5, G3)).

% 2. Fill 3 gallons bottle,
mov(fill3, state(G5, _), state(G5, 3)).

% 3. Put 5 gallons in 3 gallons bottle.
% Option 3.1:
mov(put5in3, state(G5, G3), state(0, GT)):-
  GT is G5 + G3, GT =< 3.
  
% Option 3.2:
mov(put5in3, state(G5, G3), state(G5N , 3)):-
  GT is G5 + G3, GT > 3, G5N is GT - 3.

% 4. Put 3 gallons in 5 gallons bottle.
% Option 4.1:
mov(put3in5, state(G5, G3), state(GT, 0)):-
  GT is G5 + G3, GT =< 5.
  
% Option 4.2:
mov(put3in5, state(G5, G3), state(5, G3N)):-
  GT is G5 + G3, GT > 5, G3N is GT - 5.
  

% 5. Empty 5 gallons bottle.
mov(empty5, state(_, G3), state(0, G3)).

% 6. Empty 3 gallons bottle.
mov(empty3, state(G5, _), state(G5, 0).


% 3. Creating a path

% path(+InitialState, +FinalState, +Visited, -Path)
%
% it is true if Path unify with a list of movements to go
% from InitialState to FinalState without repeating states
% in Visited list of states. 

path(Initial, Initial, _,[]).

path(Initial, Final, Visited, [MovName|Path):-
  mov(MovName, Initial, Temp),
  \+member(Temp, Visited),
    path(Temp, Final, [Temp|Visited], Path).
	
	
	
	

