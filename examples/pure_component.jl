using CubicEoSDatabase

println("Physical parameteres of methane from `martinez` database.")
for (field, value) in gcp("martinez", "methane")
    println("$field\t$value")
end
println()

println("Brusylovsky's equation of state parameteres of methane.")
for (field, value) in gce("brusylovsky", "methane")
    println("$field\t$value")
end
