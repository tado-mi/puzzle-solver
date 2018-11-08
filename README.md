# Knights_and_Knaves.pl
please, refer to comments for explanation of the logic

## usage
* plug in the code to a prolog interpreter ([SWISH]()).
* 'translate' your puzzle to the format that contains Statements of the acceptable formats:

	X is a Y	where X and Y can be {Varaible, knight, knave}<br/>
	X says S	where X can be {Variable, knight, knave} and S is a statement<br/>
	S1 or S2	<br/>
	S1 and S2	<br/>
	not S		<br/>

**for example:** 'James says at least one of George and Brian is a knave' can be translated to 'James says George is a knave or Brian is a knave'.

* plug in the translated statement as an argument to function solve/1
* make sure to hit **;** instead of **.** to see all possible solutions to the puzzle

# disclaimer
the code has been **heavily** inspired by the course material provided at the course [Semantic and Declarative Technologies](http://cs.bme.hu/~szeredi/ait/) at [AIT](https://www.ait-budapest.com/) by [Peter Szeredi](http://cs.bme.hu/~szeredi/).
