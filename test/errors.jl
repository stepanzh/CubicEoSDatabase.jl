@testset "Error Constructor" begin
    @test_throws CubicEoSDatabase.NotFoundError throw(CubicEoSDatabase.NotFoundError("methane", "foo database"))
end
