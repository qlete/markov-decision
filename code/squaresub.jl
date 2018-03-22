# Implement the substitution of a square by 3 for our paticular board game
# Examples for noncicular case: 
#   subsquare(2,false) = 1; subsquare(12,false) = 2; subsquare(8,false) = 5
# Example for circular case:
#   subsquare(2,true) = 10 
function squaresub(square::Int64, circular::Bool)
    if square <= 3
        if circular
            if square == 1
                return 9
            elseif square == 2
                return 10
            elseif square == 3
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