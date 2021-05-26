# API Reference

## Preliminary

[Delimited-separated values](https://en.wikipedia.org/wiki/Delimiter-separated_values) (DSV file) — a text file representing tabular data by using a column delimiter char (e.g. `.tsv`, `.csv`).

!!! warning "DSV file size"
    As the package is built upon DelimitedFiles, a source file is loaded to RAM.
    Keep in mind size of your DSV files.

We suppose that a row of source datafile uniquely determined by values at first `K` columns (e.g. names of components).
We called these columns *primary keys* or just *keys*.

## Types and accessors

### Private types

```@docs
CubicEoSDatabase.AbstractTabularDatabase
```

### Accessors

```@docs
data
header
reference
source
Base.keys(::CubicEoSDatabase.AbstractTabularDatabase)
```

### Public types

```@docs
ComponentDatabase
MixtureDatabase
```

## Database requests

!!! warning "Linear request time"
    Current implementation of requests takes ``O(N)`` time, where ``N`` is number of rows in source file.

```@docs
getentry
getmatrix
```

### Error handling

```@docs
CubicEoSDatabase.NotFoundError
```
