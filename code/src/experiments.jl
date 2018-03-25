include("markovDecision.jl")
include("simulate.jl")


board1 = [0,0,0,0,0,2,0,0,1,1,2,2,0,0,0]
board2 = [0,1,2,1,2,2,1,0,0,0,0,0,0,0,0]
board3 = ones(Int64, 15)

boards = [board1, board2, board3]
c = [false, true]

for board in boards
    println("--- Board : ", board, " ---")
    for circular in c
        if !circular
            println("Non-circular")
        else
            println("Circular")
        end
        (expec, dice) = markovdecision(board, circular)
        println("\tExpected cost = ", round(expec[1],3))
        allsim = Vector{Int64}()
        for i=1:1000
        	push!(allsim, simulate(board, dice, circular))
        end
        println("\tSimulated cost = ", mean(allsim))
    end
end

