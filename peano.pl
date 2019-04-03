

substr(X, 0, X).
substr(X, n(Y), Z):- substr(X, Y, n(Z)).

d2p(0,0).
d2p(D, n(P)):- D > 0, D2 is - 1, d2p(D2,P).


% p2d(+P, -D)
% it is true if D unify with a 
% decimal number equivalent to the
% Peano representation of P

p2d(0, 0).
p2d(n(X), D2):- p2d(X, D), D2 is D + 1.

% times(?X, ?Y, ?Z)
% it is true if Z unify with X * Y in Peano Arithmetic
% it is true if Z unify with a Peano number
% equivalent to add X, Y times

times(_, 0, 0).

times(X, n(Y), R):- times (X, Y, Z), sum(X, Z, R).


