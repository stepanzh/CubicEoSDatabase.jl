# CubicEoSDatabase.jl

Database of parameters for different cubic equations of state. The database is aimed at pure alkanes and its mixtures.

Currently, most covered equation of state is Brusylovsky's (general) equation of state.

# Installing

1. Go to Julia REPL.
2. Activate packager mode (press `]`).
3. Run `(v1.2) pkg> add https://gitlab.com/stepanzh/cubiceosdatabase.jl`.

After installing you can test package by `(v1.2) pkg> test CubicEoSDatabase`.

# Minimal Working Examples

## getentry(db, key): get info of a component

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

comp_eos = ComponentDatabase("brusylovsky.csv")
d = getentry(comp_eos, "methane")
# `d` is Dict{String,Any}(
#     "critical_omega" => 0.7563,
#     "name" => "methane",
#     "psi" => 0.37447,
#     "critical_compressibility" => 0.33294
# )
```

## getentry(db, key1, key2): get info about pair of components

Suppose a file `mix_brusylovsky.csv` collecting pair-interaction parameters of components

```
comp1,comp2,constant,linear,quadratic
nitrogen,n-heptane,0.168,0.000558,0
methane,ethane,-0.015,0.000123,-0.41
methane,propane,0.019,0.000502,0
methane,n-butane,0.031,0.000502,0
```

```julia
using CubicEoSDatabase

mix_eos = MixtureDatabase("mix_brusylovsky.csv")
d = getentry(mix_eos, "methane", "ethane")
# `d` is Dict{String,Any}(
#     "constant" => -0.015,
#     "linear" => 0.000123,
#     "comp2" => "ethane",
#     "comp1" => "methane",
#     "quadratic" => -0.41
# )
```

## getmatrix(db, keys[, diag=0.0]): get matrix of pairwise parameters

Recall `mix_brusylovsky.csv` from MVE for `getentry(db, key1, key2)`. Function `getmatrix(db, keys)` constructs pair-interaction matrices for `keys`. It supposes that a parameter-column named `A` of source file contains `A_ij` coefficients, where `i` and `j` are keys (indices) stored in first two columns of corresponding row.

```julia
using CubicEoSDatabase

mix_eos = MixtureDatabase("mix_brusylovsky.csv")
d = getmatrix(mix_eos, ("methane", "ethane"))
# `d` is Dict(
#     "constant" => [0.0 -0.015; -0.015 0.0],
#     "linear" => [0.0 0.000123; 0.000123 0.0],
#     "quadratic" => [0.0 -0.41; -0.41 0.0]
# )
```

Diagonal elements are zeros by default.
