"""
Provides interface for loading parameteres of components and mixtures from
*separated values* files.

See `ComponentDatabase`, `BinaryMixtureDatabase`, `getentry`, `getmatrix`.

Out-of-box database stored in `CubicEoSDatabase.Data` module.
"""
module CubicEoSDatabase
    using DelimitedFiles

    export Data
    export ComponentDatabase, MixtureDatabase
    export data, header, reference, source
    export getentry, getmatrix

    include("types.jl")
    include("errors.jl")
    include("requests.jl")
    include("Data.jl")
end
