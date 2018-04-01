# Simulating games to verify expected cost (`simulate.jl`)

Now that we are able to get the expected cost and optimal dice strategy,
it is time to *verify* if those corresponds correctly to what happens
when *simulated* games using randomness are put into place.
Note that in order to compare those, one will need to repeat
the experiments multiple number of times and this will be done
in the two last sections.

```@docs
simulate
simulate_k
oneturn
```