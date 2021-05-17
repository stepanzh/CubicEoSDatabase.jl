using CubicEoSDatabase


comp_phys = CubicEoSDatabase.Data.martinez()
comp_eos = CubicEoSDatabase.Data.brusilovskii_comp()
mix_eos = CubicEoSDatabase.Data.brusilovskii_mix()

println(getentry(comp_phys, "methane"))
println(getentry(comp_eos, "methane"))
println(getentry(mix_eos, "methane", "ethane"))
println(getmatrix(mix_eos, ("methane", "ethane")))
