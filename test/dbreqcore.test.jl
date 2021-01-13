ismet = CubicEoSDatabase.ismet
gr = CubicEoSDatabase.get_first_row

@testset "ismet(): does sample meets conditions?" begin
    conds = ["ABC", missing, "CDE"]
    @test ismet(conds, ["ABC", "smth", "CDE", "smth else"] ) == true
    @test ismet(conds, ["abc", "smth", "CDE", "smth else"] ) == false
    @test ismet(["methane"], ["methane", "0.016", "191", "4600000", "0.01", "0.288"]) == true
    @test ismet([missing, "0.016"], ["methane", "0.016", "191", "4600000", "0.01", "0.288"]) == true
    @test_throws ErrorException ismet(["cond_1", "cond_2"], ["target_1"])
end

@testset "gr(): gotten row correct?" begin
    f = open(joinpath(CubicEoSDatabase.DBROOT, "phys/comp/martinez.csv"))
    r = Reader(f ; sep=',', quotechar='"')
    @test gr(r, ["methane"]) == ["methane", "0.01604276", "1", "191", "4600000", "0.01", "0.288"]
    close(f)
end
