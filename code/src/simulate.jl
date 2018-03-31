export simulate, simulate_k, oneturn

include("traps.jl")

"""
    simulate(list, dice, circular)

Returns the cost (number of dice throws) of a
a complete simulation of a Snakes and Ladders game, meaning
it starts at square 1, with a board disposition described
in `list`, a dice strategy (dice to play at each square) in `dice`
and the circularity of the board indicated in `circular`.
"""
function simulate(list::Vector{Int64}, dice::Vector{Int64}, circular::Bool)
    simulate_k(list, dice, circular, 1)
end

"""
    simulate_k(list, dice, circular, k)

Returns the cost (number of dice throws) of
a simulation of a Snakes and Ladders game, starting at square `k`,
with a board disposition described
in `list`, a dice strategy (dice to play at each square) in `dice`
and the circularity of the board indicated in `circular`.
"""
function simulate_k(list::Vector{Int64}, dice::Vector{Int64}, circular::Bool, k::Int64)
	cost = 0
	box = k
	while box != 15
		box = oneturn(list, box, dice[box], circular)
		# println(box)
		cost = cost + 1
	end
	return cost
end


"""
    oneturn(list, start, dice, circular)

This function is used in the `simulate` function and played until
the current square is not the square 15. Given the board disposition
in `list` and its circularity in `circular`, the current square `start`
and the `dice` to be played, it will return the next square (using
random variables to simulate the dice and traps behaviors).
"""
function oneturn(list::Vector{Int64}, start::Int64, dice::Int64, circular::Bool)
	startatthree = false
	if (start >= 11) && (start <= 14)
		path = 2
	else
		path = 1
	end
	if start == 3
		startatthree = true
		if rand([false, true])
			path = 2
			start = 10
		end
	end
	if dice == 1
		nextbox = start + rand(0:1)
	elseif dice == 2
		nextbox = start + rand(0:2)
	elseif dice == 3
		nextbox = start + rand(0:3)
	end
	if path == 1
		if nextbox > 10
			if !circular
				return 15
			else
				if nextbox != 11
					nextbox = nextbox - 11
				else
					return 15
				end
			end
		end
	else
		if nextbox > 14
			if !circular
				return 15
			else
				if nextbox > 15
					nextbox = nextbox - 15
				else
					return 15
				end
			end
		end
		if (startatthree) && (nextbox == 10)
			nextbox = 3
		end
	end
	if dice == 1
		return nextbox
	elseif dice == 2
		if rand([false, true])
			return nextsquare(list[nextbox], nextbox)
		else
			return nextbox
		end
	elseif dice == 3
		return nextsquare(list[nextbox], nextbox)
	end
end

function nextsquare(square_type, nextbox)
    if square_type == 0
    	return nextbox
    elseif square_type == 1
    	return applytrap1(nextbox)
    elseif square_type == 2
    	return applytrap2(nextbox)
    elseif square_type == 3
    	return applytrap3(nextbox)
    end
end