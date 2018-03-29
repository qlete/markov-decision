
"""
    applytrap1(list)

Computes the transition probability matrix for the risky dice
with squares types defined in `list` and circularity of
board defined by `circular`.
"""
function applytrap1(square::Int64)
    return squaresub(square, 15)
end


function applytrap2(square::Int64)
    return squaresub(square, 3)
end

function applytrap3(square::Int64)
    return convert(Int64, ceil(rand()*15))
end

function squaresub(square::Int64, k::Int64)
    if k == 0
        return square
    elseif square <= k+1
        return 1
    end
    if square == 11
        return squaresub(3, k-1)
    else            
        return squaresub(square-1, k-1)
    end
end