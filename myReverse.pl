% reverse(+List, - Result)
% it is true if Result is a list
% that contains same elements than List
% but in reverse
%
% ? myReverse([1,2,3,4],R)
% R = [4,3,2,1]

% 1) myReverse([], []).                 
myReverse([], []).

% 2) myReverse(n-1) -> myReverse(n)
%    myReverse(n) :- myReverse(n-1)

myReverse([Head|Tail],R2):- myReverse(Tail, R),
	 append(R, [Head],R2).

% myReverse([1,2,3,4], ):- myReverse([2,3,4], [4,3,2]



