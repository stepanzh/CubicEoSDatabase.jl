# Out-of-box database

Out-of-box database of physical and equation of state parameters lives in [`Data`](@ref) submodule.

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

## A I Brusilovsky (general) equation of state

[Brusilovsky, SPE Reservoir Engineering, February 1992](https://doi.org/10.2118/20180-PA)

This is a cubic 4-parameter equation of state. It has the following form for a component

```math
P(\upsilon, T) = \frac{RT}{\upsilon - b} - \frac{a(T)}{(\upsilon + c)(\upsilon + d)},
```

where

- ``P, \upsilon, T`` are pressure, molar volume and temperature of a substance respectively;
- ``a(T)`` is temperature-dependent EoS parameter;
- ``b, c, d`` are constant EoS parameters.

The reason we call this equation of state "general" is that it can be transformed into common-used Soave-Redlich-Kwong and Peng-Robinson equations of state. This comes from internal relations between ``a(T), b, c`` and ``d``.

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
