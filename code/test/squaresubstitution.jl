function squaresubtests() 
    @testset "Move k backward" begin
        @testset "Non circular" begin
            circular = false
            k = 3
            @test squaresub(1, circular, k) == 1
            @test squaresub(2, circular, k) == 1
            @test squaresub(3, circular, k) == 1
            @test squaresub(4, circular, k) == 1
                           
            @test squaresub(11, circular, k) == 1
            @test squaresub(12, circular, k) == 2
            @test squaresub(13, circular, k) == 3
        end
        @testset "Circular" begin
            circular = true
            k = 3
            @test squaresub(1, circular, k) == 9
            @test squaresub(2, circular, k) == 10
            @test squaresub(3, circular, k) == 15
            @test squaresub(4, circular, k) == 1
            
            @test squaresub(11, circular, k) == 1
            @test squaresub(12, circular, k) == 2
            @test squaresub(13, circular, k) == 3
        end
    end
end