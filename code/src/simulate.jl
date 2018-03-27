include("squaresub.jl")

# Simulates a game of snake & ladder starting at a box 1
# input  :  - list : trap list
#           - dice : dice strategy 
#           - circular : true if game is circular
#  
# output :  - cost : total cost (number of dice throws)
function simulate(list::Vector{Int64}, dice::Vector{Int64}, circular::Bool)
    simulate_k(list, dice, circular, 1)
end

# Simulates a game of snake & ladder starting at a given box
# input  :  - list : trap list
#           - dice : dice strategy 
#           - circular : true if game is circular
#           - k : start box
#
# output :  - cost : total cost (number of dice throws)
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


# Implements one turn of the game given the start position and the dice
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
			if list[nextbox] == 0
				return nextbox
			elseif list[nextbox] == 1
				return 1
			elseif list[nextbox] == 2
				return squaresub(nextbox, circular, 3)
			end
		else
			return nextbox
		end
	elseif dice == 3
		if list[nextbox] == 0
			return nextbox
		elseif list[nextbox] == 1
			return 1
		elseif list[nextbox] == 2
			return squaresub(nextbox, circular, 3)
		end
	end
end