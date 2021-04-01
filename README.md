# CubicEoSDatabase.jl

Database of parameters for different cubic equations of state. The database is aimed at pure alkanes and its mixtures.

Currently, most covered equation of state is Brusylovsky's (general) equation of state.

# Installing

1. Go to Julia REPL.
2. Activate packager mode (press `]`).
3. Run `(v1.2) pkg> add https://gitlab.com/stepanzh/cubiceosdatabase.jl`.

After installing you can test package by `(v1.2) pkg> test CubicEoSDatabase`.

# Minimal Working Examples

## getentry(db, key) -- get info of a component

Suppose a file named `brusylovksy.csv` which collects eos-parameters

```
name,critical_compressibility,critical_omega,psi
nitrogen,0.34626,0.75001,0.37182
methane,0.33294,0.7563,0.37447
ethane,0.31274,0.77698,0.49550
propane,0.31508,0.76974,0.53248
n-butane,0.31232,0.76921,0.57594
n-pentane,C5+,C5+,C5+
n-hexane,C5+,C5+,C5+
n-heptane,C5+,C5+,C5+
n-octane,C5+,C5+,C5+
n-decane,C5+,C5+,C5+
```

```julia
using CubicEoSDatabase

comp_eos = ComponentDatabase("example_database/eos/comp/brusylovsky.csv")
println(getentry(comp_eos, "methane"))
# produces output
# Dict{String,Any}("critical_omega" => 0.7563,"name" => "methane","psi" => 0.37447,"critical_compressibility" => 0.33294)
```
