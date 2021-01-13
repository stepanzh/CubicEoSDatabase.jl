@testset "ComponentDatabase" begin
    @test_throws ErrorException CubicEoSDatabase.ComponentDatabase(name="a", source="_non_existing_file.txt")
end
