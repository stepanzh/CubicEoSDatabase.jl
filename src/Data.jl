"""
Repository database of thermodynamical properties.

Exported methods are

- `martinez()::ComponentDatabase`: gas properties of substances;
- `brusilovsky_comp()::ComponentDatabase`: parameters of A I Brusilovskii equation of state for pure components;
- `brusilovsky_mix()::MixtureDatabase`: binary parameters of A I Brusilovskii equation of state for mixtures.
"""
module Data

using ..CubicEoSDatabase

export martinez, brusilovsky_comp, brusilovsky_mix

"Cache of a database `::T`. Stores arguments needed to initialize `T`."
mutable struct CachedDatabase{T,A,KW}
    value::Union{Nothing,T}
    calculated::Bool
    args::A     # `T(args...; kwargs...)` constructor arguments
    kwargs::KW  #
    function CachedDatabase(::Type{T}, args, kwargs) where {T}
        new{T,typeof(args),typeof(kwargs)}(nothing, false, args, kwargs)
    end
end

function value(x::CachedDatabase{T,A,KW}) where {T,A,KW}
    if !x.calculated
        x.value = T(x.args...; x.kwargs...)
        x.calculated = true
    end
    return x.value::T
end

"Root path of database source files."
const root = joinpath(abspath(@__DIR__), "../data")

const CachedMartinez = CachedDatabase(ComponentDatabase,
    (joinpath(root, "phys/comp/martinez.csv"),),
    (reference="Website (loaded in 2017): http://imartinez.etsiae.upm.es/~isidoro/dat1/eGAS.pdf", delim=',')
)

"""
    Data.martinez() -> ComponentDatabase

I Martinez gas properties.
"""
martinez() = value(CachedMartinez)

const brusilovsky_book = "A I Brusilovskii. Fazovie prevrasheniya pri razrabotke mestorozhdeniy nefti i gaza (Phase transitions during mining of petroleum and gas). 2002. Moscow, Graal’. ISBN: 5-94688-031-4. (in Russian)"
const CachedBrusilovskyComp = CachedDatabase(ComponentDatabase,
    (joinpath(root, "eos/comp/brusilovsky.csv"),),
    (reference=brusilovsky_book, delim=',')
)

"""
    Data.brusilovsky_comp() -> ComponentDatabase

A I Brusilovsky equation of state. Parameters for pure components.
"""
brusilovsky_comp() = value(CachedBrusilovskyComp)

const CachedBrusilovskyMixture = CachedDatabase(MixtureDatabase,
    (joinpath(root, "eos/mix/brusilovsky.csv"),),
    (reference=brusilovsky_book, delim=',')
)

"""
    Data.brusilovsky_mix() -> MixtureDatabase

A I Brusilovsky equation of state. Binary parameters for mixtures.
"""
brusilovsky_mix() = value(CachedBrusilovskyMixture)

end # module
