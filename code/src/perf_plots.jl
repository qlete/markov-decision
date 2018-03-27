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
# plot (simulated VS expected cost) % (number of simulations) starting at box 1
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
    nb_iter = [1000*i for i=1:50]
    y = [simulatedcost(board, dice, circular, start_box, x) for x in nb_iter]
    
    # plot both
    plot!(nb_iter, y, marker="o",
        label=["Simulated cost"],
        xlabel=("Number of simulations"),
        ylabel=("Cost"))
    hline!([expected_cost_from_1]; label="Expected cost")
    return fig
end
p = plotcost_pernbsim()
savefig(p, "../../img/cost_iterations.pdf")



##########
# PLOT 2 #
##########    
# plot simulated cost VS expected for every start box

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
p, figname = plotcost_persquare()
savefig(p, figname)



