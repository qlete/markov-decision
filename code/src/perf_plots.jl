export plotcost_pernbsim, plotcost_persquare

using Plots

include("markovDecision.jl")
include("simulate.jl")

function simulatedcost(board, dice, circular, start_box, nb_iter)
    allsim = Vector{Int64}()
    for i=1:nb_iter
    	push!(allsim, simulate_k(board, dice, circular, start_box))
    end
    return mean(allsim)
end

##########
# PLOT 1 #
##########    
"""
    plotcost_pernbsim()

Plot both the simulated and expected cost for multiple number of simulations
of a game starting at square 1.
"""
function plotcost_pernbsim()
    fig = plot()
    # define board
    board = [0,0,0,0,0,2,0,0,1,1,2,2,0,0,0]
    circular = false
    # expected cost
    (expec, dice) = markovdecision(board, circular)
    expected_cost_from_1 = expec[1]
    
    # simulated cost
    start_box = 1
    powers = [i for i=1:7]
    nb_iter = [10^i for i in powers]
    y = [simulatedcost(board, dice, circular, start_box, x) for x in nb_iter]
    
    # plot both
    plot!(powers, y, marker="o",
        label=["Simulated cost"],
        xlabel=("Log 10 number of simulations"),
        ylabel=("Cost"))
    hline!([expected_cost_from_1]; label="Expected cost")
    return fig
end
# p = plotcost_pernbsim()
# savefig(p, "../../img/cost_iterations_log.pdf")



##########
# PLOT 2 #
##########    
"""
    plotcost_persquare()

Plot both the simulated and expected cost for starting the game at every square
(one square is one x-axis point).
This allows to check whether each expected cost corresponds to the simulated one,
when the game is repeated multiple times.
"""
function plotcost_persquare()
    fig = plot()
    # define board
    board = [0,0,0,0,0,2,0,0,1,1,2,2,0,0,0]
    circular = false
    # expected cost
    (expec, dice) = markovdecision(board, circular)
    
    nb_iter = 10
    squares = [i for i=1:15]
    y = [simulatedcost(board, dice, circular, square, nb_iter) for square in squares]
    
    scatter!(squares, y,
        color=("blue"),
        label=["Simulated cost"]
        )
        
    scatter!(squares, expec,
        color=("red"),
        #label=["Expected cost"],
        xlabel=("Square number"),
        ylabel=("Cost")
        )
    
    figname = "../../img/cost_per_square_" * string(nb_iter) * "_iter.pdf"
    return fig, figname
end
# p, figname = plotcost_persquare()
# savefig(p, figname)



