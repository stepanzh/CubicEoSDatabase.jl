# CubicEoSDatabase.jl

<!--
old gitlab pipeline
[![pipeline status](https://gitlab.com/stepanzh/cubiceosdatabase.jl/badges/master/pipeline.svg)](https://gitlab.com/stepanzh/cubiceosdatabase.jl/-/commits/master) -->
[![documetation here](https://img.shields.io/badge/docs-latest-informational.svg)](https://stepanzh.github.io/CubicEoSDatabase.jl/)
[![Code Style: Blue](https://img.shields.io/badge/code%20style-blue-4495d1.svg)](https://github.com/invenia/BlueStyle)

*Loading parameters of equations of state from plain text.*

The package provides interface to separated-values files describing *parameters for cubic equations of state*.
The package is **free of third-party text parsers** like [CSV.jl](https://github.com/JuliaData/CSV.jl).

Currently, the most described equation of state is **Brusilovsky**'s (general) equation of state [[Brusilovsky SPE Reservoir Engineering 1992](https://doi.org/10.2118/20180-PA)], which is easily transformed into common-known **Peng-Robinson** or **Soave-Redlich-Kwong** equations. Originally, the package is aimed at modelling pure alkanes and its mixtures.

Package's **documentation** is available [here](https://stepanzh.github.io/CubicEoSDatabase.jl/).

The package comes with **Out-of-box database** of gas properties and eos parameters.
For a quick preview of embedded substances see [this](https://stepanzh.github.io/CubicEoSDatabase.jl/stable/outofboxdb/).
The database can be accessed from `CubicEoSDatabase.Data` submodule. See `help?> CubicEoSDatabase.Data`.

For **minimal working examples** see `test/example.jl`.

# Installing

1. Go to Julia REPL;
2. Activate packager mode (press `]`);
3. Run `(v1.6) pkg> add CubicEosDatabase`.

After installing you can test package by `(v1.6) pkg> test CubicEoSDatabase`.
