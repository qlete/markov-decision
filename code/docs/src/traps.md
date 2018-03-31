# Defining the traps

A first need is to make a function capable of returning the resulting
square when we need to go back from *k* squares.
This is done in a simple recursive fashion in the ```squaresub``` method.
```@docs
squaresub
```

Once it is define, it will allow us to construct traps 1 and 2
very easily as trap 1 is equavalent to making the user go back of 15 squares
and trap 2 of 3 squares.
Only trap3 has a special form has it does not even depend of the current
square but we still left the argument for the genericity.
```@docs
applytrap1
applytrap2
applytrap3
```