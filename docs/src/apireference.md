# API Reference

## Preliminary

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
```

```@docs
MixtureDatabase
```

## Database requests

```@docs
getentry
getmatrix
```
