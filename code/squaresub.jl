# Implement the substitution of a square by k

using Base.Test

function squaresub_k(square::Int64, circular::Bool, k::Int64)
    if k == 0
        return square
    end
    if square == 1
        if circular
            if k == 1
                return 15
            else
                return squaresub_k(10, circular, k-2)
            end
        else
            return 1
        end
    elseif square == 11
        return squaresub_k(3, circular, k-1)
    else            
        return squaresub_k(square-1, circular, k-1)
    end
end

function squaresubtests() 
    @testset "Move k backward" begin
        @testset "Non circular" begin
            circular = false
            k = 3
            @test squaresub_k(1, circular, k) == 1
            @test squaresub_k(2, circular, k) == 1
            @test squaresub_k(3, circular, k) == 1
            @test squaresub_k(4, circular, k) == 1
                           
            @test squaresub_k(11, circular, k) == 1
            @test squaresub_k(12, circular, k) == 2
            @test squaresub_k(13, circular, k) == 3
        end
        @testset "Circular" begin
            circular = true
            k = 3
            @test squaresub_k(1, circular, k) == 9
            @test squaresub_k(2, circular, k) == 10
            @test squaresub_k(3, circular, k) == 15
            @test squaresub_k(4, circular, k) == 1
            
            @test squaresub_k(11, circular, k) == 1
            @test squaresub_k(12, circular, k) == 2
            @test squaresub_k(13, circular, k) == 3
        end
    end
end

squaresubtests()