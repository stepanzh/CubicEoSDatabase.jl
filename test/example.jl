using CubicEoSDatabase


comp_phys = CubicEoSDatabase.Data.martinez()
comp_eos = CubicEoSDatabase.Data.brusilovsky_comp()
mix_eos = CubicEoSDatabase.Data.brusilovsky_mix()

println(getentry(comp_phys, "methane"))
println(getentry(comp_eos, "methane"))
println(getentry(mix_eos, "methane", "ethane"))
println(getmatrix(mix_eos, ("methane", "ethane")))

println("\nI Martinez' database (repository version) includes gas properties of")
for (i, k) in enumerate(keys(comp_phys))
    println("  $i.\t$k")
end

println("\nA I Brusilovsky's database (repository version) of binary parameters collects pairs")
for (i, k) in enumerate(keys(mix_eos))
    println("  $i.\t$(k[1]) + $(k[2])")
end
