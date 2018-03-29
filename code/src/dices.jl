export securitydice

"""
    securitydice(list)

Computes the transition probability matrix for the security dice
with squares types defined in `list`.
"""
function securitydice(list::Vector{Int64})::Array{Float64,2}
    proba = zeros(15, 15)
    for i = 1:14
        proba[i,i] = 0.5
        if i == 3
            proba[i,i+1] = 0.25
            proba[i,i+8] = 0.25
        elseif i == 10
            proba[i,i+5] = 0.5
        else
            proba[i,i+1] = 0.5
        end
    end
    proba[15,15] = 1
    return proba
end

# Computes the transition probability matrix for the normal dice
function normaldice(list::Vector{Int64}, circular::Bool)::Array{Float64,2}
    proba = zeros(15, 15)
    # Compute first the transition proba matrix as if there were no traps
    p = 1/3
    for i = 1:14
        proba[i,i] = p
        if i == 3
            proba[i,i+1] = p/2
            proba[i,i+2] = p/2
            proba[i,i+8] = p/2
            proba[i,i+9] = p/2
        elseif i == 9
            proba[i,i+1] = p
            proba[i,i+6] = p
        elseif i == 10
            if circular
                proba[i,i+5] = p
                proba[i,(i+6) % 15] = p
            else
                proba[i,i+5] = 2*p
            end
        elseif i == 14
            if circular
                proba[i,i+1] = p
                proba[i,(i+2) % 15] = p
            else
                proba[i,i+1] = 2*p
            end
        else
            proba[i,i+1] = p
            proba[i,i+2] = p
        end
    end
    proba[15,15] = 1

    # Remodify each line to take traps into account
    for i = 1:15
        for j = 1:15
            if list[j] == 1 # Trap of type 1 : go back to square 1
                if j != 1 
                    proba[i,1] = proba[i,1] + proba[i,j]/2
                    proba[i,j] = proba[i,j]/2
                end
            elseif list[j] == 2 # Trap of type 2 : go back three squares
                proba[i,squaresub(j,circular, 3)] = proba[i,squaresub(j,circular, 3)] + proba[i,j]/2
                proba[i,j] = proba[i,j]/2
            end
        end
    end
    return proba
end

# Computes the transition probability matrix for the risky dice
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
                if j != 1 
                    proba[i,1] = proba[i,1] + proba[i,j]
                    proba[i,j] = 0
                end
            elseif list[j] == 2 # Trap of type 2 : go back three squares
                proba[i,squaresub(j,circular, 3)] = proba[i,squaresub(j,circular, 3)] + proba[i,j]
                proba[i,j] = 0
            end
        end
    end
    return proba
end
