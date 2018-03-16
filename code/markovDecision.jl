# Run the MDP value iteration algorithm
function markovdecision(list::Vector{Int64}, circular::Bool)
    # Get transition probability matrices
    A = securitydice(list)
    C = riskydice(list, circular)
    # Initialize value vector
    oldV = zeros(15)
    newV = [float(i) for i = 14:-1:0] 
    while sum(abs.(newV-oldV)) > 1e-9
        oldV = copy(newV)
        for i = 1:14
            newV[i] = 1 + min(A[i,:]'*oldV, C[i,:]'*oldV)
        end
        newV[15] = min(A[15,:]'*oldV, C[15,:]'*oldV)
        println(newV)
    end

    dice = zeros(15)
    for i = 1:15
        dice[i] = indmin([A[i,:]'*newV, C[i,:]'*newV])
    end
    return((newV,dice))
end

# Computes the transition probability matrix for the security dice
function securitydice(list::Vector{Int64})::Array{Float64,2}
    proba = zeros(15, 15)
    for i = 1:14
        proba[i,i] = 0.5
        if i == 3
            proba[i,i+1] = 0.25
            proba[i,i+8] = 0.25
        else
            proba[i,i+1] = 0.5
        end
    end
    proba[15,15] = 1
    return proba
end

# Implement the substitution of a square by 3 for our paticular board game
# Examples for noncicular case: 
#   subsquare(2,false) = 1; subsquare(12,false) = 2; subsquare(8,false) = 5
# Example for circular case:
#   subsquare(2,true) = 10 
function squaresub(square::Int64, circular::Bool)
    if square <= 3
        if circular
            if i == 1
                return 9
            elseif i == 2
                return 10
            elseif i == 3
                return 15
            end
        else
            return 1
        end
    else
        if square == 11
            return 2
        elseif square == 12
            return 3
        elseif square == 13
            return 4
        elseif square == 15
            return 8
        else
            return square-3
        end
    end
end

# Computes the transition probability matrix for the risky dice
# in the noncircular case
function riskydice(list::Vector{Int64}, circular::Bool)::Array{Float64,2}
    proba = zeros(15, 15)
    # Compute first the transition proba matrix as if there were no traps
    for i = 1:14
        proba[i,i] = 0.25
        if i == 3
            proba[i,i+1] = 0.125
            proba[i,i+2] = 0.125
            proba[i,i+3] = 0.125
            proba[i,i+8] = 0.125
            proba[i,i+9] = 0.125
            proba[i,i+10] = 0.125
        elseif i == 8
            proba[i,i+1] = 0.25
            proba[i,i+2] = 0.25
            proba[i,i+7] = 0.25
        elseif i == 9
            proba[i,i+1] = 0.25
            if circular
                proba[i,i+6] = 0.25
                proba[i,i-8] = 0.25
            else
                proba[i,i+6] = 0.5
            end
        elseif i == 10
            if circular
                proba[i,i+5] = 0.25
                proba[i,i-9] = 0.25
                proba[i,i-8] = 0.25
            else
                proba[i,i+5] = 0.75
            end
        elseif i == 13
            proba[i,i+1] = 0.25
            if circular
                proba[i,i+2] = 0.25
                proba[i,i-12] = 0.25
            else
                proba[i,i+2] = 0.5
            end
        elseif i == 14
            if circular
                proba[i,i+1] = 0.25
                proba[i,i-13] = 0.25
                proba[i,i-12] = 0.25
            else
                proba[i,i+1] = 0.75
            end
        elseif i == 15
            proba[i,i] = 1
        else
            proba[i,i+1] = 0.25
            proba[i,i+2] = 0.25
            proba[i,i+3] = 0.25
        end
    end
    proba[15,15] = 1

    # Remodify each line to take traps into account
    for i = 1:15
        for j = 1:15
            if list[j] == 1 # Trap of type 1 : go back to square 1
                proba[i,1] = proba[i,1] + proba[i,j]
                proba[i,j] = 0
            elseif list[j] == 2 # Trap of type 2 : go back three squares
                proba[i,squaresub(j,circular)] = proba[i,squaresub(j,circular)] + proba[i,j]
                proba[i,j] = 0
            end
        end
    end
    return proba
end

List = [0,0,0,2,2,1,0,0,1,1,0,2,1,0,0]
circular = false
(Expec, Dice) = markovdecision(List, circular)
println(Expec)
println(Dice)