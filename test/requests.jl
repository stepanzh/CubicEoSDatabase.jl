@testset "Requests" begin

@testset "getentry for component" begin
    martinez = Data.martinez()

    @test getentry(martinez, "methane") isa Dict
    @test_throws CubicEoSDatabase.NotFoundError getentry(martinez, "philosophic_stone")
    @test getentry(martinez, "methane") == Dict(
        :name => "methane",
        :molecular_mass => 0.01604276,
        :critical_temperature => 191.0,
        :critical_pressure => 4600000.0,
        :acentric_factor => 0.01,
        :critical_compressibility => 0.288,
        :number_carbons => 1,
    )

    eos = Data.brusilovskii_comp()
    @test getentry(eos, "methane") isa Dict
    @test_throws CubicEoSDatabase.NotFoundError getentry(eos, "philosophic_stone")
    @test getentry(eos, "methane") == Dict(
        :name => "methane",
        :critical_compressibility => 0.33294,
        :critical_omega => 0.7563,
        :psi => 0.37447
    )
    @test getentry(eos, "n-octane") == Dict(
        :name => "n-octane",
        :critical_compressibility => "C5+",
        :critical_omega => "C5+",
        :psi => "C5+"
    )
end
@testset "getentry for binary" begin
    binary = Data.brusilovskii_mix()
    @test getentry(binary, "methane", "n-pentane") isa Dict
    @test_throws CubicEoSDatabase.NotFoundError getentry(binary, "methane", "philosophic_stone")

    @testset "Ordered requests" begin
        @test_throws CubicEoSDatabase.NotFoundError getentry(binary, "n-pentane", "methane", keeporder=true)
        @test getentry(binary, "methane", "n-pentane") == getentry(binary, "methane", "n-pentane", keeporder=true)
    end

    @test getentry(binary, "methane", "n-pentane") == Dict(
        :comp1 => "methane",
        :comp2 => "n-pentane",
        :constant => 0.001,
        :linear => 0.000604,
        :quadratic => 0
    )
end

@testset "getmatrix" begin
    db = Data.brusilovskii_mix()
    @test getmatrix(db, ("methane", "propane", "ethane")) isa Dict{Symbol,Matrix{Float64}}
    @test_throws CubicEoSDatabase.NotFoundError getmatrix(db, ("methane", "philosophic_stone"))
    
    response = getmatrix(db, ("methane", "propane", "ethane"))
    @test response[:constant] == [0 0.019 -0.015; 0.019 0 -0.015; -0.015 -0.015 0]
    @test response[:linear] == [0 0.000502 0.000123; 0.000502 0 0; 0.000123 0 0]
    @test response[:quadratic] == [0 0 -0.41; 0 0 0; -0.41 0 0]
end

end  # @testset