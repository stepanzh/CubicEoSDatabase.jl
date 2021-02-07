@testset "Database types" begin

@testset "ComponentDatabase" begin
    @test ComponentDatabase("example_database/phys/comp/martinez.csv") isa CubicEoSDatabase.AbstractTabularDatabase
    @test_throws ArgumentError ComponentDatabase("example_database/phys/comp/galaxy.csv")
end

@testset begin
    @test MixtureDatabase("example_database/eos/mix/brusylovsky.csv") isa MixtureDatabase
    @test_throws ArgumentError MixtureDatabase("example_database/eos/mix/galaxy.csv")
end

end # @testset
