% with the intention of using as (+E, ?P, +P')
% -- what are all possible lists P, such that if E is removed from P, P' is obtained
% helping predicate for permutation
% base case
select(E, [E|T], T).
% recursive case
select(E, [H|T], [H|RTail]) :-
	select(E, T, RTail).

% permutation
% base case
permutation([], []).
% recursive case
permutation([H|T], P) :-
	permutation(T, PTail),	% PTail is all possible permutations of the T
	select(H, P, PTail).	% Since P is unknown, select will return all its possible values:
				% all lists that would contain both PTail and H
				% in other words, it inserts H anywhere it can in PTail and saves in P

% calc(operand, operand, operation, result)
% with the intention of using as calc(+O1, +O2, ?O, +R).
% -- how to combine O1 and O2 to obtain R, if possible at all
calc(O1, O2, O, R) :-
	O = '+', R is (O1 + O2);
	O = '-', R is (O1 - O2);
	O = '*', R is (O1 * O2);
	O = '/', \+ O2 = 0, R is (O1 / O2).

% the main function
% solve(+List of numbers, ?Result, -Solution)
% base case
solve_h([X, Y], R, Solution) :-
	calc(X, Y, Operation, R), Solution = [X, Operation, Y].
% recursive case
solve_h(L, R, Solution) :-
	L = [X | T],
	% TR is all the possible values we van obtain from the Tail of the List
	% TS is how we will obtain its corresponding TR
	solve(T, TR, TS),
	% if we can obtain R with the given List, it is possible with the operator O
	solve([X, TR], R, [X, O, TR]),
	Solution = [X, O|TS].

solve(L, R, Solution) :-
	permutation(L, P),		% moving permutation 'down' does not create extra choice points
	solve_h(P, R1, Solution),
	R1 =:= R.			% 24.0 =:= 24 returns true, elevating the nessecity from the user to insert floating point number
