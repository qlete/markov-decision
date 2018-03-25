include("markovDecision.jl")
include("simulate.jl")


#list = [0,0,0,0,0,2,0,0,1,1,2,2,0,0,0]
list = [0,1,2,1,2,2,1,0,0,0,0,0,0,0,0]

circular = false
(expec, dice) = markovdecision(list, circular)
println(expec)
println(dice)
allsim = Vector{Int64}()
for i=1:1000
	push!(allsim, simulate(list, dice, circular))
end
println("Expected cost = ", mean(allsim))