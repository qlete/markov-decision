using Documenter, SnakeLadder

makedocs(
    format = :html,
    sitename = "SnakeLadder.jl",
    pages = [
    "Intro" => "index.md",
    "Dices" => "dices.md",
    "Performance plots" => "perf_plots.md"]
)