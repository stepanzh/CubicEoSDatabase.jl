# Home

*Loading parameters of equations of state from source files.*

The package provides wrappers (see [Types and accessors](@ref)) for [separated-values](https://en.wikipedia.org/wiki/Delimiter-separated_values) files and requests methods (see [Database requests](@ref)).

## Features

- Works with DSV text files
- Lightweight, no third-party dependencies. Based on built-in [DelimitedFiles](https://docs.julialang.org/en/v1/stdlib/DelimitedFiles/)
- Includes [Out-of-box database](@ref)

# Quick start

## Obtaining parameters of components

```@setup rawsource
brusilovsky_comp = """
    name,critical_compressibility,critical_omega,psi
    nitrogen,0.34626,0.75001,0.37182
    methane,0.33294,0.7563,0.37447
    n-butane,0.31232,0.76921,0.57594
    n-hexane,C5+,C5+,C5+
    """
brusilovsky_mix = """
    comp1,comp2,constant,linear,quadratic
    nitrogen,n-heptane,0.168,0.000558,0
    methane,ethane,-0.015,0.000123,-0.41
    methane,propane,0.019,0.000502,0
    methane,n-butane,0.031,0.000502,0
    propane,n-butane,-0.063,0.000559,0
    """

print(open("brusilovsky.csv", "w"), brusilovsky_comp)
print(open("brusilovsky_mix.csv", "w"), brusilovsky_mix)

nothing
```

Suppose a file `brusilovsky.csv` which collects eos-parameters of *components*

```@repl rawsource
read(open("brusilovsky.csv"), String) |> print
```

To obtain parameters of a component (e.g. methane) wrap the source file with [`ComponentDatabase`](@ref) and use [`getentry`](@ref)

```@repl rawsource
using CubicEoSDatabase
comp_eos = ComponentDatabase("brusilovsky.csv");
getentry(comp_eos, "methane")
```

## Obtaining parameters of pair of components

Some parameters of equation of state are determined by pair of components (e.g. binary interaction).

Suppose a file `brusilovsky_mix.csv` collecting binary interaction parameters.

```@repl rawsource
read(open("brusilovsky_mix.csv"), String) |> print
```

To obtain parameters of methane + ethane wrap the source file with [`MixtureDatabase`](@ref) and use [`getentry`](@ref)

```@repl rawsource
using CubicEoSDatabase
mix_eos = MixtureDatabase("brusilovsky_mix.csv");
getentry(mix_eos, "methane", "ethane")
```

### Obtaining matrices of binary parameters

Actually, the file `brusilovsky_mix.csv` stores three matrices with coefficients

- ``C_{ij}`` in column 'constant'
- ``L_{ij}`` in column 'linear'
- ``Q_{ij}`` in column 'quadratic'

where ``i, j`` are names of components (columns 'comp1' and 'comp2').

To obtain these matrices for mixture of methane, propane and n-butane, do the following

```@repl
using CubicEoSDatabase
mix_eos = MixtureDatabase("brusilovsky_mix.csv");
getmatrix(mix_eos, ("methane", "propane", "n-butane"); diag=0.0)
```

## Index

```@index
```
