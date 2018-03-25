# Implement the substitution of a square by k

function squaresub(square::Int64, circular::Bool, k::Int64)
    if k == 0
        return square
    end
    if square == 1
        if circular
            if k == 1
                return 15
            else
                return squaresub(10, circular, k-2)
            end
        else
            return 1
        end
    elseif square == 11
        return squaresub(3, circular, k-1)
    else            
        return squaresub(square-1, circular, k-1)
    end
end