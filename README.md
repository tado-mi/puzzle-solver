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

## sample run:

| ?- solve(James is a knight).<br/>
James = knight ? ;<br/>
no<br/>
<br/>
| ?- solve(James says George says George is a knave).<br/>
James = knave,<br/>
George = knight ? ;<br/>
James = knave,<br/>
George = knave ? ;<br/>
no<br/>
<br/>
| ?- J = (James is a knight), solve(not J).<br/>
J = (knave is a knight),<br/>
James = knave ? ;<br/>
no<br/>
<br/>
| ?- solve(James says James is a knight or George is a knave and Chris is a knave).<br/>
James = knight,<br/>
George = knight,<br/>
Chris = knight ? ;<br/>
James = knight,<br/>
George = knight,<br/>
Chris = knave ? ;<br/>
James = knight,<br/>
George = knave,<br/>
Chris = knight ? ;<br/>
James = knight,<br/>
George = knave,<br/>
Chris = knave ? ;<br/>
James = knave,<br/>
George = knight,<br/>
Chris = knight ? ;<br/>
James = knave,<br/>
George = knight,<br/>
Chris = knave ? ;<br/>
James = knave,<br/>
George = knave,<br/>
Chris = knight ? ;<br/>
no<br/>

# 24_Game.pl

**wikipedia:** The 24 Game is an arithmetical [card game](https://en.wikipedia.org/wiki/Card_game) in which the objective is to find a way to manipulate four integers so that the end result is 24. <br/>
**full page:** [link](https://en.wikipedia.org/wiki/24_Game)

## the idea:

use the predicate **solve/3**, whith the arguments *list*, *result*, *?solution*. Introduction of *result* makes it more generic than just 24.<br/>

* try all the possible permutations and operator assignments to the given list of numbers.
* compute the value and compare to the result

## the code:

Iteratively assign values/operators to last (n - 1) items of the number list and 'glews' the first number with all the possible operator assignment.<br/>

**note** that such approach considers expressions of form that correspond to the following tree:<br/>

	/\
	 /\
	  /\
	   ...

That can be serious limitation. For example, if the result can be satisfied by x<sub>1</sub>x<sub>2</sub> + x<sub>3</sub>x<sub>4</sub> assignment only, the code will fail.

# Sudoku.pl
*yeap, yet another one of those!*
