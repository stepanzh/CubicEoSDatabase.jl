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
)

deploydocs(;
    repo = "github.com/stepanzh/CubicEoSDatabase.jl.git",
    devbranch = "main",
)
