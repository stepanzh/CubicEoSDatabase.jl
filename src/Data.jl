"""
Repository database of thermodynamical properties.

Exported methods are

- `martinez()::ComponentDatabase`: gas properties of substances;
- `brusilovskii_comp()::ComponentDatabase`: parameters of A I Brusilovskii equation of state for pure components;
- `brusilovskii_mix()::MixtureDatabase`: binary parameters of A I Brusilovskii equation of state for mixtures.
"""
module Data

using ..CubicEoSDatabase

export martinez, brusilovskii_comp, brusilovskii_mix

"Root path of database source files."
root = joinpath(abspath(@__DIR__), "../data")

"I Martinez gas properties."
martinez() = ComponentDatabase(
    joinpath(root, "phys/comp/martinez.csv"),
    reference="Website (loaded in 2017): http://imartinez.etsiae.upm.es/~isidoro/dat1/eGAS.pdf",
    delim=','
)

brusilovskii_book = "A I Brusilovskii. Fazovie prevrasheniya pri razrabotke mestorozhdeniy nefti i gaza (Phase transitions during mining of petroleum and gas). 2002. Moscow, Graal’. ISBN: 5-94688-031-4. (in Russian)"
"A I Brusilovskii equation of state parameters for pure components."
brusilovskii_comp() = ComponentDatabase(
    joinpath(root, "eos/comp/brusilovskii.csv"),
    reference=brusilovskii_book,
    delim=','
)
"A I Brusilovskii equation of state binary parameters for mixtures."
brusilovskii_mix() = MixtureDatabase(
    joinpath(root, "eos/mix/brusilovskii.csv"),
    reference=brusilovskii_book,
    delim=','
)

end # module