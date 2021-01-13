using CubicEoSDatabase

constant, linear, quadratic = gbie("brusylovsky", "methane", "n-butane")

println("Binary interactive coefficients of methane + n-butane mixture.")
println(constant)
println(linear)
println(quadratic)
