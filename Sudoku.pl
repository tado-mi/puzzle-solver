:- use_module(library(between)).

% helper methods:

% prefix(+List, +Length, ?Prefix):
% Prefix is a list containing first Length elements of List
prefix(L, N, P) :-
    append(P, _, L),
    length(P, N).

% suffix(+List, +Length, ?Suffix):
% Suffix is a list containing last Length elements of List
suffix(L, N, S) :-
    append(_, S, L),
    length(S, N).

% merge(+ListOfLists, ?List):
% ListOfLists is of form [[A, B], C, [D, E]]
% List is of form [A, B, C, D, E]
merge([], []).
merge([H|T], L) :-
    merge(T, LT),
    append(H, LT, L).

% is_unique(+L):
% whether elements in L are pairwise different
is_unique([]).
is_unique([H|T]) :-
    H = 0 -> is_unique(T)
    ;
    \+ member(H, T), is_unique(T).

% unique(+L): L is a list of lists,
% unique(L) checks whether elements in each of the sublists are pairwise  different
unique([]).
unique([H|T]) :-
    is_unique(H),
    unique(T).

% transpose(+M, ?T).
% M is of form [R1, R2 ... RN], where RI is the Ith row of the matrix
% source: https://github.com/perkola/matrix/blob/master/matrix.pl
transpose([], []).
transpose([U], B) :-
	gen(U, B).
transpose([H|T], R) :-
	transpose(T, TC), splash(H, TC, R).

gen([H|T], [[H]|RT]) :- gen(T,RT).
gen([], []).

splash([], [], []).
splash([H|T], [R|K], [[H|R]|U]) :-
    splash(T,K,U).

% extract_blocks(+RowList, +Size, -BlockList)
extract_blocks([], _, []).
extract_blocks(R, S, B) :-
    transpose(R, RT),
    length(RT, L), 
    Rest is L - S,
    prefix(RT, S, B1Temp),
    merge(B1Temp, B1),
    suffix(RT, Rest, SuffT),
    transpose(SuffT, Suff),
    extract_blocks(Suff, S, B2),
    append([B1], B2, B).
    
% blocks(+RowList, +Size, ?BlockList)
blocks([], _, []).
blocks(R, S, B) :-
    length(R, L),
    Rest is L - S,
    prefix(R, S, Pref),
    suffix(R, Rest, Suff),
    extract_blocks(Pref, S, B1),
    blocks(Suff, S, B2),
    append(B1, B2, B).

blocks(RowList, BlockList) :-
    length(RowList, N),
    K is round(sqrt(N)),		% size of the size of the Block
    blocks(RowList, K, BlockList).

insert_row([], [], _).
insert_row([X|T], [SX|ST], Range) :-
    insert_row(T, ST, Range),		% deal with the 'remaning' elements in the row
    (   X = 0 -> between(1, Range, SX)
    ;   SX = X
    ).

insert_values([], [], _).
insert_values([Row | T], [SRow | ST], Range) :-
    insert_values(T, ST, Range), 	% deal with the 'remaining' rows
    insert_row(Row, SRow, Range).	% twitch the values of the 'current' row

consistent(RowList) :-
  unique(RowList),
  transpose(RowList, ColumnList),	
  unique(ColumnList),
  blocks(RowList, BlockList), 
  unique(BlockList).

% sudoku(+Grid, ?SGrid)
sudoku(Grid, SGrid) :-
    consistent(Grid),			% whether or not Grid could be solved
    write('yes'), nl,
    length(Grid, Range),		
    insert_values(Grid, SGrid, Range),	% insert values into SGrid 
    consistent(SGrid).			% verify if SGrid is a solution

test(SGrid) :-
	Grid = [[ 1, 0, 0, 0 ],
		[ 0, 0, 2, 0 ],
		[ 0, 3, 0, 0 ],
		[ 0, 0, 0, 4 ]],
	sudoku(Grid, SGrid).
