# Project 1 : Markov Decision Processes
Markov decision process for the snake and ladder game.


## TODO

- [ ] should we really let 1 for the case "go back to 1" ? would it not be better that k means to go back k boxes and set a limit for the number of boxes to go back, then from this limit define other numbers meaning **go back to 1** or **stay in prison for 1 turn** etc.
- [ ] curves representing the precision when number of experiments are repeated and check it for by starting from all boxes (and not only the first one) : change `simulate` function (or add new one) so it takes the start box into account
- [ ] have a cool kind of **graphical interface** to visual expected cost and what dice to play seeing the whole game
- [ ] sub-optimal strategies comparison (use of only some dices)
- [ ] performance function(s)

### Particular scenarios or rules
- [ ] prison block
- [ ] block that allow to *play only certain dice(s) at the next throw*
- [ ] no trap blocks, only trap blocks (mixed, particuliar trap, etc.)

