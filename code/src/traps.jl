
"""
    applytrap1(square)

Returns the next square after trap 1, meaning going back to square 1,
has been applied when being at `square`.
"""
function applytrap1(square::Int64)
    return squaresub(square, 15)
end

"""
    applytrap2(square)

Returns the next square after trap 2, meaning going back 3 squares,
has been applied when being at `square`.
"""
function applytrap2(square::Int64)
    return squaresub(square, 3)
end

"""
    applytrap3(square)

Returns the next square after trap 3 (the magic trap),
meaning that one can go to every one of the 15 other squares
with equal probability, has been applied when being at `square`.
"""
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