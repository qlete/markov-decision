include("squaresub.jl")
include("dices.jl")

# Run the MDP value iteration algorithm
function markovdecision(list::Vector{Int64}, circular::Bool)::Tuple{Vector{Float64},Vector{Int64}}
    # Get transition probability matrices
    A = securitydice(list)
    B = normaldice(list, circular)
    C = riskydice(list, circular)
    
    # Initialize value vector
    oldV = zeros(15)
    newV = [float(i) for i = 14:-1:0] 
    # newV = []
    while sum(abs.(newV-oldV)) > 1e-9
        oldV = copy(newV)
        for i = 1:14
            newV[i] = 1 + min(A[i,:]'*oldV, B[i,:]'*oldV, C[i,:]'*oldV)
        end
        newV[15] = min(A[15,:]'*oldV, B[15,:]'*oldV, C[15,:]'*oldV)
        # println(newV)
    end

    dice = zeros(Int64, 15)
    for i = 1:15
        dice[i] = indmin([A[i,:]'*newV, B[i,:]'*newV, C[i,:]'*newV])
    end
    return((newV,dice))
end

function printmarkovresults(list, expec, dice)
    #println("- RESULT")
    board_print = "Board \t|"
    expec_print = "Cost \t|"
    dice_print = "Dice \t|"
    for i=1:15
        board_print = board_print * string(list[i]) * "\t|"
        expec_print = expec_print * string(round(expec[i],3)) * "\t|"
        dice_print = dice_print * string(dice[i]) * "\t|"
    end
    println(board_print * "\n" * expec_print * "\n" * dice_print)
end

function makeexperiments()
    board1 = [0,0,0,0,0,2,0,0,1,1,2,2,0,0,0]
    board2 = [0,1,2,1,2,2,1,0,0,0,0,0,0,0,0]
    board3 = ones(Int64, 15)

    boards = [board1, board2, board3]
    c = [false, true]

    for board in boards
        println("Board : ", board)
        println("-- Noncircular --")
        (expec, dice) = markovdecision(board, false)
        printmarkovresults(board, expec, dice)
    
        println("-- Circular --")
        (expec, dice) = markovdecision(board, true)
        printmarkovresults(board, expec, dice)
        println()
    end
end

# makeexperiments()

