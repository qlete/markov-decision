# Implement the substitution of a square by k

function squaresub(square::Int64, circular::Bool, k::Int64)
    if k == 0
        return square
    elseif square <= k+1
        return 1
    end
    if square == 11
        return squaresub(3, circular, k-1)
    else            
        return squaresub(square-1, circular, k-1)
    end
end