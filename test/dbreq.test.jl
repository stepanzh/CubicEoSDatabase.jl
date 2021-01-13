@testset "Database request test" begin
    @testset "gcp(): get component physics" begin
        @test gcp("martinez", "methane") == Dict(
            "name"      => "methane",
            "mass"      => 0.01604276,
            "ctemp"     => 191.0,
            "cpres"     => 4600000.0,
            "acentr"    => 0.01,
            "ccompres"  => 0.288,
            "ncarb"     => 1,
        )
        @test_throws DomainError gcp("martinez", "phylosophic_stone")
        @test_throws DomainError gcp("galaxy_db", "phylosophic_stone")
    end
    @testset "gce(): get componet eos" begin
        @test gce("brusylovsky", "methane") == Dict(
            "name"      => "methane",
            "ccompres"  => 0.33294,
            "comega"    => 0.7563,
            "psi"       => 0.37447
        )
        @test gce("brusylovsky", "n-octane") == Dict(
            "name"      => "n-octane",
            "ccompres"  => LOADASC5,
            "comega"    => LOADASC5,
            "psi"       => LOADASC5
        )
        @test_throws DomainError gcp("brusylovsky", "phylosophic_stone")
        @test_throws DomainError gce("supremeDB", "air")
    end
    @testset "gbie(): get bin. interact. eos params" begin
        #   brusylovsky parameters
        methane_propane_b = Dict(
            "name1" => "methane",
            "name2" => "propane",
            "const" => 0.019,
            "lin"   => 0.000502,
            "quad"  => 0
        )
        #   pr parameters
        methane_propane_pr = Dict(
            "name1" => "methane",
            "name2" => "propane",
            "const" => 0.01,
            "lin"   => 0,
            "quad"  => 0
        )
        let
            c, l, q = gbie("brusylovsky", "methane", "propane")
            # methane,propane,0.019,0.000502,0
            @test c == [0 0.019; 0.019 0]
            @test l == [0 0.000502; 0.000502 0]
            @test q == fill(0.0, (2,2))
        end

        # methane,propane,0.019,0.000502,0
        # methane,ethane,-0.015,0.000123,-0.41
        # ethane,propane,-0.015,0,0
        let
            c, l, q = gbie("brusylovsky", "methane", "propane", "ethane")
            @test c == [0 0.019 -0.015; 0.019 0 -0.015; -0.015 -0.015 0]
            @test l == [0 0.000502 0.000123; 0.000502 0 0; 0.000123 0 0]
            @test q == [0 0 -0.41; 0 0 0; -0.41 0 0]
        end
        @test_throws DomainError gbie("brusylovsky", "phylosophic_stone", "methane")
        @test_throws DomainError gbie("supremeDB", "methane", "propane")
    end
end
