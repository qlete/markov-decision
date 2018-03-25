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

function printmatrix(t_mat)
    n = size(t_mat)[1]
    for i = 1:n
        println(t_mat[i,:])
    end
end

function makeexperiments()
    list = [0,0,0,0,0,2,0,0,1,1,2,2,0,0,0]
    println(list, "\n")
    
    println(" --- Noncircular --- ")
    (expec, dice) = markovdecision(list, false)
    println("cost ", expec)
    println("dice ", dice)
    
    println(" --- Circular --- ")
    (expec, dice) = markovdecision(list, true)
    println("cost ", expec)
    println("dice ", dice)
    
    list = [0,1,2,1,2,2,1,0,0,0,0,0,0,0,0]
    println("\n", list, "\n")
    
    println(" --- Noncircular --- ")
    (expec, dice) = markovdecision(list, false)
    println("cost ", expec)
    println("dice ", dice)
    
    println(" --- Circular --- ")
    (expec, dice) = markovdecision(list, true)
    println("cost ", expec)
    println("dice ", dice)
end