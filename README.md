# CubicEoSDatabase.jl

Database of parameters for different cubic equations of state. The database is aimed at pure alkanes and its mixtures.

Currently, most covered equation of state is Brusylovsky's (general) equation of state.

# Documentation

Documentation is available [here](https://stepanzh.gitlab.io/cubiceosdatabase.jl/).

# Installing

1. Go to Julia REPL.
2. Activate packager mode (press `]`).
3. Run `(v1.5) pkg> add https://gitlab.com/stepanzh/cubiceosdatabase.jl`.

After installing you can test package by `(v1.2) pkg> test CubicEoSDatabase`.

# Sample (out-of-box) database
Repository provides databases of gas properties and eos parameters.

They can be accessed from `CubicEoSDatabase.Data` nested module. See `help?> CubicEoSDatabase.Data`.

Available components can be viewed by `keys(x::ComponentDatabase), keys(x::MixtureDatabase)`.

# Minimal Working Examples

See `test/example.jl` and `test/example_database/`.
