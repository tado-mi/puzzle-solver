Included are Prolog files for solving various mathematical puzzles. Files are commented out, explaining the logic and the purpose of defined predicates. <br/>

It has been written whith the use of course materials provided at [Semantic and Declarative Technologies](http://cs.bme.hu/~szeredi/ait/) course at [AIT](https://www.ait-budapest.com/) by [Peter Szeredi](http://cs.bme.hu/~szeredi/). <br/>


To compile and use, plug in the code to a prolog interpreter. [SWISH](http://swish.swi-prolog.org/) is a free option.

# Knights_and_Knaves.pl

**wikipedia:** Knights and Knaves is a type of [logic puzzle](https://en.wikipedia.org/wiki/Logic_puzzle) where some characters can only answer questions truthfully (knights), and others only falsely(knaves). The name was coined by [Raymond Smullyan](https://en.wikipedia.org/wiki/Raymond_Smullyan) in his 1978 work *What Is the Name of This Book?* <br/>
**full page:** [link](https://en.wikipedia.org/wiki/Knights_and_Knaves)

## the idea:

'translate' the puzzle such that it contains of the forms supported, which are:

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

| ?- solve(James is a knight).
James = knight ? ;
no

| ?- solve(James says George says George is a knave).
James = knave,
George = knight ? ;
James = knave,
George = knave ? ;
no

| ?- J = (James is a knight), solve(not J).
J = (knave is a knight),
James = knave ? ;
no

| ?- solve(James says James is a knight or George is a knave and Chris is a knave).
James = knight,
George = knight,
Chris = knight ? ;
James = knight,
George = knight,
Chris = knave ? ;
James = knight,
George = knave,
Chris = knight ? ;
James = knight,
George = knave,
Chris = knave ? ;
James = knave,
George = knight,
Chris = knight ? ;
James = knave,
George = knight,
Chris = knave ? ;
James = knave,
George = knave,
Chris = knight ? ;
no

# 24_Game.pl

**wikipedia:** The 24 Game is an arithmetical [card game](https://en.wikipedia.org/wiki/Card_game) in which the objective is to find a way to manipulate four integers so that the end result is 24. <br/>
**full page:** [link](https://en.wikipedia.org/wiki/24_Game)
