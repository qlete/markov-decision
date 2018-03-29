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

"""
    plotcost_pernbsim(board)

Plot both the simulated and expected cost for multiple number of simulations
of a game starting at square 1.
"""
function plotcost_pernbsim(board)
    fig1 = plot()
    # define board
    circular = false
    # expected cost
    (expec, dice) = markovdecision(board, circular)
    expected_cost_from_1 = expec[1]
    
    # cost plot
    start_box = 1
    powers = [i for i=1:7]
    nb_iter = [10^i for i in powers]
    y = [simulatedcost(board, dice, circular, start_box, x) for x in nb_iter]
    
    plot!(powers, y, marker="o",
        label=["Simulated cost"],
        xlabel=("Log 10 number of simulations"),
        ylabel=("Cost"))
    hline!([expected_cost_from_1]; label="Expected cost")
    
    # error plot
    fig2 = plot()
    error = [abs(expected_cost_from_1 - simulated_cost) for simulated_cost in y]/expected_cost_from_1
    plot!(powers, error, marker="o",
        label=["Error"],
        xlabel=("Log 10 number of simulations"),
        ylabel=("Relative error"))
        
    return fig1, fig2
end


"""
    plotcost_persquare(board)

Plot both the simulated and expected cost for starting the game at every square
(one square is one x-axis point).
This allows to check whether each expected cost corresponds to the simulated one,
when the game is repeated multiple times.
"""
function plotcost_persquare(board)
    fig = plot()
    # define board
    circular = false
    # expected cost
    (expec, dice) = markovdecision(board, circular)
    
    nb_iter = 100
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

board_unif_low = [0,1,0,0,2,0,1,0,2,0,0,1,0,2,0]
# 
plot_cost, plot_errors = plotcost_pernbsim(board_unif_low)
savefig(plot_cost, "../../img/cost_iterations_log.pdf")
savefig(plot_errors, "../../img/error_iterations_log.pdf")

#
p, figname = plotcost_persquare(board_unif_low)
savefig(p, figname)

