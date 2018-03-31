using Documenter, SnakeLadder

makedocs(
    format = :html,
    sitename = "SnakeLadder.jl",
    pages = [
    "Summary" => "index.md",
    "Dices" => "dices.md",
    "Traps" => "traps.md",
    "Markov decision" => "markov.md",
    "Simulate cost" => "simulate.md",
    "Performance plots" => "perf_plots.md",
    "Some experiments" => "experiments.md"]
)