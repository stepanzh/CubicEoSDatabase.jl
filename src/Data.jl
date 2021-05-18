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

"Root path of database source files."
root = joinpath(abspath(@__DIR__), "../data")

"I Martinez gas properties."
martinez() = ComponentDatabase(
    joinpath(root, "phys/comp/martinez.csv"),
    reference="Website (loaded in 2017): http://imartinez.etsiae.upm.es/~isidoro/dat1/eGAS.pdf",
    delim=','
)

brusilovsky_book = "A I Brusilovskii. Fazovie prevrasheniya pri razrabotke mestorozhdeniy nefti i gaza (Phase transitions during mining of petroleum and gas). 2002. Moscow, Graal’. ISBN: 5-94688-031-4. (in Russian)"
"A I Brusilovskii equation of state parameters for pure components."
brusilovsky_comp() = ComponentDatabase(
    joinpath(root, "eos/comp/brusilovsky.csv"),
    reference=brusilovsky_book,
    delim=','
)
"A I Brusilovskii equation of state binary parameters for mixtures."
brusilovsky_mix() = MixtureDatabase(
    joinpath(root, "eos/mix/brusilovsky.csv"),
    reference=brusilovsky_book,
    delim=','
)

end # module