function squaresubtests() 
    @testset "Move k backward" begin
        @testset "k=3" begin
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
        @testset "k=1" begin
            circular = false
            k = 1
            @test squaresub(1, circular, k) == 1
            @test squaresub(2, circular, k) == 1
            @test squaresub(3, circular, k) == 2
            @test squaresub(4, circular, k) == 3
            
            @test squaresub(11, circular, k) == 3
            @test squaresub(12, circular, k) == 11
            @test squaresub(13, circular, k) == 12
        end
        @testset "k=10" begin
            circular = false
            k = 10
            @test squaresub(1, circular, k) == 1
            @test squaresub(2, circular, k) == 1
            @test squaresub(3, circular, k) == 1
            @test squaresub(4, circular, k) == 1
            
            @test squaresub(11, circular, k) == 1
            @test squaresub(12, circular, k) == 1
            @test squaresub(13, circular, k) == 1
        end
    end
end