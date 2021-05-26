# Out-of-box database

Out-of-box database of physical and equation of state parameters lives [`Data`](@ref) submodule.

## A I Martinez database of gas properties

This database can be accessed by [`Data.martinez`](@ref).

**Reference**

```@repl
using CubicEoSDatabase; reference(Data.martinez()) |> print
```

### Available components

```@repl
using CubicEoSDatabase; join(keys(Data.martinez()), '\n') |> print
```

## A I Brusilovsky equation of state

### Parameters for pure components

This database can be accessed by [`Data.brusilovsky_comp`](@ref).

**Reference**

```@repl
using CubicEoSDatabase; reference(Data.brusilovsky_comp()) |> print
```

#### Available components

```@repl
using CubicEoSDatabase; join(keys(Data.brusilovsky_comp()), '\n') |> print
```

### Binary interaction parameters

This database can be accessed by [`Data.brusilovsky_mix`](@ref).

**Reference**

```@repl
using CubicEoSDatabase; reference(Data.brusilovsky_mix()) |> print
```

#### Available pairs

```@repl
using CubicEoSDatabase; join(keys(Data.brusilovsky_mix()), '\n') |> print
```
