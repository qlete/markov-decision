# Implement the substitution of a square by k

function trap1(square::Int64, k::Int64)
    return squaresub(square, 15)
end

function trap2(square::Int64, k::Int64)
    return squaresub(square, 3)
end

function trap3(square::Int64, k::Int64)
    return convert(Int64, round(rand()*15, 0))
end


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

function squaresub(square::Int64, k::Int64)
    return squaresub(square, true, k)
end