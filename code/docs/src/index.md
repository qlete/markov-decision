# SnakeLadder Project Documentation

This HTML documentation repository presents the architecture
of our code as well as detailed description of each function.
It has been made in a way that tries to mirror the thinking process
we went through while advancing in the project.

Firstly, one needs to compute the *transition matrices* to go from one
square to another and this for each of the three dices : security, normal
and risky dice. Then, the behaviour of traps are implemented, allowing us to
concretely execute our Markov decision process using the well-known
value-iteration algorithm. The latter brings us both the expected cost
and the optimal dice strategy starting from each square.
One then needs to verify that the expected cost corresponds to the simulated
and we therefore implement concrete simulation of the game.
Correctness and performance plots are then generated as they
represent a viable way of easily visualizing and prove that our results
are meaningful.
Finally, we make some experiments on particular boards disposition
and suboptimal strategies.

```@contents
Pages = [
  "dices.md", "traps.md", "markov.md", "simulate.md", "perf_plots.md", "experiments.md"
]
Depth = 3
```