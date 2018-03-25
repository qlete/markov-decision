# initial probabilities from each square
init_prob = [1/3, 1/3, 1/3]
# transition matrix
n = 10
t_mat = zeros(n,n)
# type of squares
input_list = zeros(n)
input_list[2] = 1

### fill transition matrix
# squares 1 to n-2
for i = 1:n-2
    print("Square ", i, " : ")
    if input_list[i] == 0
        println("No trap")
        t_mat[i,i:(i+2)] = init_prob
        
    elseif input_list[i] == 1
        println("Trap 1")
        trap_prob = 0.5
        t_mat[i,1] = trap_prob*1
        t_mat[i,i:(i+2)] = trap_prob*init_prob
    end
end
# square n-1
t_mat[n-1, n-1:n] = [1/3, 2/3]
# square n
t_mat[n, n] = 1

##### PRINTS #####
println("\nTransition matrix")
for i = 1:n
    println(t_mat[i,:])
end
# print(init_prob)