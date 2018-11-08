% define the 'language of communication' with Prolog

% 'a': "James is a Knight"
% a is an operator of the tightest binding: value of 650
% a is a prefix operator: fx
:- op(650, fx, a).

% 'not': "not James is a Knight"
% not is an operator of the second tightest binding: value of 700
% not is a prefix operator: fx
:- op(750, fx, not).

% 'and'
% and is an operator of tighter binding than 'or' or 'says': value of 800
% and is an infix operator: yfx
:- op(800, yfx, and).

% 'or'
% or is an operator of tighter binding than 'says': value of 900
% or is an infix operator: yfx
:- op(900, yfx, or).

% 'says': "James says Statement"
% says is an operator of least tight binding: value of 950
% says is an infix operator: xfy
:- op(950, xfy, says).

solve(Statement) :-
	% Statement holds if its evaluation is true
	evaluate(Statement, 1).

% facts
truthful(knight, 1). % Knights always tell the truth
truthful(knave,  0). % Knaves  always tell false statements

% note:

% for (B1 ≡ B2) we assess 1 - abs(B1 - B2)
% if (B1 ≡ B2), abs(B1 - B2) = 0, otherwise abs(B1 - B2) = 1 

% for (B1 or B2) we assess B1 + B2 - B1 * B2
% if none of B1 or B2 is 1, the equation gives 0
% if exaclty one of B1 or B2 is 1, B1 * B2 is 0, while B1 + B2 is 1, and the equation gives 1
% if both B1 and B2 are one, B1 * B2 is 1, while B1 + B2 is 2, so the equation gives 1

% evaluation
evaluate(Statement, V) :-

	Statement = (X is a Y) ->
		truthful(X, XBoolean), truthful(Y, YBoolean),
		% Statement is true if X and Y are the same
		Boolean is 1 - abs(XBoolean - YBoolean);

	Statement = (X says S) ->
		truthful(X, XBoolean), evaluate(S, SBoolean),
		% Statement is true if X and S are the same
		Boolean is 1 - abs(XBoolean - SBoolean) 
	;

	Statement = (S1 and S2) ->
		evaluate(S1, B1), evaluate(S2, B2),
		Boolean is B1 * B2

	;

	Statement = (S1 or S2) ->
		evaluate(S1, B1), evaluate(S2, B2),
		Boolean is B1 + B2 - B1 * B2
		
	;
	Statement = (not S) ->
		evaluate(S, B),
		Boolean is 1 - B
	.
