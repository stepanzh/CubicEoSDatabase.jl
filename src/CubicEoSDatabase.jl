module CubicEoSDatabase
    using minCSV: Reader, readrow
    using Base.Iterators: zip

    export LOADASC5, gcp, gce, gbie, list_database

    include("types.jl")
    include("config.jl")
    include("dbreqcore.jl")
    include("dbreq.jl")
    include("listdatabase.jl")
end
