# CubicEoSDatabase.jl

<!--
old gitlab pipeline
[![pipeline status](https://gitlab.com/stepanzh/cubiceosdatabase.jl/badges/master/pipeline.svg)](https://gitlab.com/stepanzh/cubiceosdatabase.jl/-/commits/master) -->
[![documetation here](https://img.shields.io/badge/docs-latest-informational.svg)](https://stepanzh.github.io/CubicEoSDatabase.jl/)
[![Code Style: Blue](https://img.shields.io/badge/code%20style-blue-4495d1.svg)](https://github.com/invenia/BlueStyle)

Database of parameters for different cubic equations of state. The database is aimed at pure alkanes and its mixtures.

Currently, most covered equation of state is Brusylovsky's (general) equation of state.

# Documentation

Documentation is available [here](https://stepanzh.github.io/CubicEoSDatabase.jl/).

# Installing

1. Go to Julia REPL.
2. Activate packager mode (press `]`).
3. Run `(v1.6) pkg> add https://github.com/stepanzh/CubicEosDatabase.jl`.

After installing you can test package by `(v1.6) pkg> test CubicEoSDatabase`.

# Sample (out-of-box) database
Repository provides databases of gas properties and eos parameters.

They can be accessed from `CubicEoSDatabase.Data` nested module. See `help?> CubicEoSDatabase.Data`.

Available components can be viewed by `keys(x::ComponentDatabase), keys(x::MixtureDatabase)`.

# Minimal Working Examples

See `test/example.jl` and `test/example_database/`.

