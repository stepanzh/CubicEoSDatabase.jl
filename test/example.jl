using CubicEoSDatabase


comp_phys = ComponentDatabase("example_database/phys/comp/martinez.csv") 
comp_eos = ComponentDatabase("example_database/eos/comp/brusylovsky.csv")
mix_eos = MixtureDatabase("example_database/eos/mix/brusylovsky.csv")

println(getentry(comp_phys, "methane"))
println(getentry(comp_eos, "methane"))
println(getentry(mix_eos, "methane", "ethane"))
println(getmatrix(mix_eos, ("methane", "ethane")))
