Included are Prolog files for solving various mathematical puzzles. Files are commented out, explaining the logic and the purpose of defined predicates. <br/>

It has been written with the use of course materials provided at [Semantic and Declarative Technologies](http://cs.bme.hu/~szeredi/ait/) course at [AIT](https://www.ait-budapest.com/) by [Peter Szeredi](http://cs.bme.hu/~szeredi/). <br/>


To compile and use, plug in the code to a prolog interpreter. [SWISH](http://swish.swi-prolog.org/) is a free option.

# Knights_and_Knaves.pl

**wikipedia:** Knights and Knaves is a type of [logic puzzle](https://en.wikipedia.org/wiki/Logic_puzzle) where some characters can only answer questions truthfully (knights), and others only falsely(knaves). The name was coined by [Raymond Smullyan](https://en.wikipedia.org/wiki/Raymond_Smullyan) in his 1978 work *What Is the Name of This Book?* <br/>
**full page:** [link](https://en.wikipedia.org/wiki/Knights_and_Knaves)

## the idea:

'translate' the puzzle such that it is a Statement of a supported form:

* Character is a (knight / knave)
* Character says Statement
* not Statement
* Statement or Statement
* Statement and Statement

feed the translation to **solve/1** predicate.

### example:

*James says at least one of George and Brian is a knave* should become *James says George is a knave or Brian is a knave*.

## the code:

* define the operations *(a, not, and, or)* we intend on using in Statements.
* list the rules of evaluating a statement of certain forms

**solve/1** predicate will call **evaluate/2** predicate. Since the Statement contains variables, prolog will try to make assignments to those variables such that the second argument to evaluate (1: true) will be satisfied.

## valid sample queries:

	| ?- solve(James is a knight).
	| ?- solve(George says George is a knave)
	| ?- solve(James says George says George is a knave).
	| ?- J = (James is a knight), solve(not J).
	| ?- solve(James says James is a knight or George is a knave and Chris is a knave).

# 24_Game.pl

**wikipedia:** The 24 Game is an arithmetical [card game](https://en.wikipedia.org/wiki/Card_game) in which the objective is to find a way to manipulate four integers so that the end result is 24. <br/>
**full page:** [link](https://en.wikipedia.org/wiki/24_Game)

## the idea:

use the predicate **solve/3**, with the arguments *list*, *result*, *?solution*. Introduction of *result* makes it more generic than just solving for 24.<br/>

* try all the possible permutations and operator assignments to the given list of numbers.
* compute the value and compare to the result

## the code:

Iteratively assign values/operators to last (n - 1) items of the number list and 'glew' the first number with all the possible operator assignments.<br/>

**note** that such approach considers expressions of form that correspond to the following tree:<br/>

	/\
	 /\
	  /\
	   ...

That can be a serious limitation. For example, if the result can be satisfied by x<sub>1</sub>x<sub>2</sub> + x<sub>3</sub>x<sub>4</sub> assignment only, the code will fail.

## possible improvements

* generalise solution to build trees of all forms

# Sudoku.pl

**wikipedia:** Sudoku (数独 sūdoku, digit-single) is a [logic](https://en.wikipedia.org/wiki/Logic)-based, [combinatorial](https://en.wikipedia.org/wiki/Combinatorics) number-placement [puzzle](https://en.wikipedia.org/wiki/Puzzle). The objective is to fill a 9×9 grid with digits so that each column, each row, and each of the nine 3×3 subgrids that compose the grid (also called "boxes", "blocks", or "regions") contains all of the digits from 1 to 9. The puzzle setter provides a partially completed grid, which for a well-posed puzzle has a single solution. 
**full page:** [link](https://en.wikipedia.org/wiki/Sudoku)

Indeed, yet another one of those! Perks unique (as far as my personal research into the web went) to this particular implementation:

* no use of the **clpfd** library
* no hard-coded predicates for breaking an nxn Grid into blocks

## the idea:

* verify if the given Grid is solvable with respect to the currently inserted values
* brute force all possible value assignments to 'empty' cells of the offered Grid
* verify if the new Grid is consistent with Sudoku rules

## the code:

Mindlessly brute-force all the possible value assignments into the provided Grid and verify whether or not it is consistent. <br/>

**blocks/2:** calls *blocks/3* predicate<br/>
**blocks/3:** takes first k = (block side size) rows of the grid, calls the *extract_blocks/3* predicate to save individual blocks from the first k rows in variable B1, and makes a recursive call for the remaining rows, saving the result in variable B2, finally appending them into the third parameter B.<br/>
<br/>
**extract_blocks/3:** transposes the provided rowlist R into variable RT, and saves first k = (block side size) rows in variable B1Temp -> B1, makes a recursive call for the remaining rows, saving the result in variable B2, finally appending B1 and B2 into the the third parameter B.

## possible improvements:

* check whether a Grid modified with brute-forced insertions is consistent with Sudoku rules during the insertion, eliminating some trivially wrong attempts to solution
* 'figure out' which cells are bound to have a certain value and insert those permanently, narrowing down the space for brute-force trials
