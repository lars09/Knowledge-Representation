
% bubbleSort)+List, -Result)
% it is true if Result unify with a list
% with same elements than List but ordered
% from lowest to highest.

bubbleSort(List, R):-
  append(L1, [E1, E2|L2], List),
  E1 > E2,
  append(L1, [E2, E1|L2], List2),
  bubbleSort(List2, R).
  
  
bubbleSort(List, List):- ordered(List).

% ordered(+List)

% it is true if List elements are ordered from
% lowest to highest

ordered([]).
ordered([_]).
ordered([E1, E2| Tail]):- E1 =< E2,
  ordered([E2|Tail]).
  