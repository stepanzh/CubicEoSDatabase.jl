push!(LOAD_PATH,"../")

using CubicEoSDatabase
using Documenter

makedocs(;
    sitename="CubicEoSDatabase.jl",
    modules=[CubicEoSDatabase],
    pages=[
        "index.md",
        "outofboxdb.md",
        "apireference.md",
    ],
    repo = "https://gitlab.com/stepanzh/cubiceosdatabase.jl/blob/{commit}{path}#{line}"
)

deploydocs(
    repo = "github.com/stepanzh/CubicEoSDatabase.jl.git",
)
