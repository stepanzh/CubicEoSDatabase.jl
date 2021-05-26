# API Reference

## Preliminary

[Delimited-separated values](https://en.wikipedia.org/wiki/Delimiter-separated_values) (DSV file) — a text file representing tabular data by using a column delimiter char (e.g. `.tsv`, `.csv`).

!!! warning "DSV file size"
    As the package is built upon DelimitedFiles, a source file is loaded to RAM.
    Keep in mind size of your DSV files.

We suppose that a row of source datafile uniquely determined by values at first `K` columns (e.g. names of components).
We called these columns *primary keys* or just *keys*.

## Main module

```@docs
CubicEoSDatabase
```

### Types and accessors

#### Private types

```@docs
CubicEoSDatabase.AbstractTabularDatabase
```

#### Accessors

```@docs
data
header
reference
source
Base.keys(::CubicEoSDatabase.AbstractTabularDatabase)
```

#### Public types

```@docs
ComponentDatabase
MixtureDatabase
```

### Database requests

!!! warning "Linear request time"
    Current implementation of requests takes ``O(N)`` time, where ``N`` is number of rows in source file.

```@docs
getentry
getmatrix
```

#### Error handling

```@docs
CubicEoSDatabase.NotFoundError
```

## Data submodule

CubicEoSDatabase.jl comes with out-of-box database. It lives in public [`Data`](@ref) submodule. See [Out-of-box database](@ref) for details.

!!! info "Databases are cached"
    Each database presented in [`Data`](@ref) is cached. So only first call will allocate memory.

```@docs
Data
Data.martinez()
Data.brusilovsky_comp()
Data.brusilovsky_mix()
```
