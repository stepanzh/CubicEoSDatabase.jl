@testset "Database types" begin

@testset "ComponentDatabase" begin
    @test Data.martinez() isa CubicEoSDatabase.AbstractTabularDatabase
    @test_throws ArgumentError ComponentDatabase("foo_db/galaxy.csv")
end

@testset "MixtureDatabase" begin
    @test Data.brusilovsky_mix() isa MixtureDatabase
    @test_throws ArgumentError MixtureDatabase("foo_db/galaxy.csv")
end

end # @testset
