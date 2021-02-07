"""
Provides interface for loading parameteres of components and mixtures from 
*separated values* files.

See `ComponentDatabase`, `BinaryMixtureDatabase`, `getentry`, `getmatrix`.
"""
module CubicEoSDatabase
    using DelimitedFiles

    export
        ComponentDatabase,
        MixtureDatabase,
        getentry,
        getmatrix
    
    include("types.jl")
    include("errors.jl")
    include("requests.jl")
end
