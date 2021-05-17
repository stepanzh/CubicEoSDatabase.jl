"Wrapper for databases. `K` is number of primary keys."
abstract type AbstractTabularDatabase{K} end

header(::AbstractTabularDatabase) = error("MethodUndefined")
data(::AbstractTabularDatabase) = error("MethodUndefined")
source(::AbstractTabularDatabase) = error("MethodUndefined")
reference(::AbstractTabularDatabase) = "no reference"

"""
    keys(atd::AbstractTabularDatabase{K})

Return an iterator over all keys in `atd`.
For `AbstractTabularDatabase{1}` key is string.
For `AbstractTabularDatabase{K≥2}` key is `Tuple` of length `K` with strings.
"""
Base.keys(x::AbstractTabularDatabase{K}) where {K} = begin
    return (tuple(key...) for key in eachrow(@view data(x)[:, 1:K]))  # key is first K columns of a row
end
Base.keys(x::AbstractTabularDatabase{1}) = begin
    return (key for key in @view data(x)[:, 1])
end

Base.show(io::IO, x::AbstractTabularDatabase{K}) where {K} = begin
    s = string(Base.typename(typeof(x))) * "(\"$(source(x))\")"
    print(io, s)
end

"""
  ComponentDatabase(source[; delim, reference])

Wraps `source` file formatted as separated values.
Aimed at tables with single primary key (e.g. component name).

# Arguments

- `source::AbstractString`: path to source file
- `delim::AbstractChar=','`: column delimiter used in `source`
- `reference::AbstractString`: optional biblio-reference describing `source`
"""
struct ComponentDatabase{S<:AbstractString,V<:Tuple{Vararg{Symbol}},M<:Matrix} <: AbstractTabularDatabase{1}
    header::V     # tuple of headers in `source` 
    data::M       # Matrix with data from `source`
    source::S     # abspath to source file
    reference::S  # optional biblio-reference to `source`

    function ComponentDatabase(source; reference="no reference", delim=',')
        source = abspath(source)
        data, header = readdlm(source, delim, header=true)
        header = tuple(map(Symbol, header)...)
        length(header) < 2 && throw(ArgumentError("Souce file contains too few columns: $(header)"))
        return new{typeof(reference),typeof(header),typeof(data)}(header, data, source, reference)
    end
end

header(x::ComponentDatabase) = x.header
data(x::ComponentDatabase) = x.data
source(x::ComponentDatabase) = x.source
reference(x::ComponentDatabase) = x.reference

"""
  MixtureDatabase(source[; delim, reference])

Wraps `source` file formatted as separated values.
Aimed at tables with two primary keys (e.g. two names of components for binary interaction coefficients).

# Arguments

- `source::AbstractString`: path to source file
- `delim::AbstractChar=','`: column delimiter used in `source`
- `reference::AbstractString`: optional biblio-reference describing `source`
"""
struct MixtureDatabase{S<:AbstractString,V<:Tuple{Vararg{Symbol}},M<:Matrix} <: AbstractTabularDatabase{2}
    header::V
    data::M
    source::S
    reference::S

    function MixtureDatabase(source; reference="no reference", delim=',')
        source = abspath(source)
        data, header = readdlm(source, delim, header=true)
        header = tuple(map(Symbol, header)...)
        length(header) < 3 && throw(ArgumentError("Souce file contains too few columns: $(header)"))
        return new{typeof(reference),typeof(header),typeof(data)}(header, data, source, reference)
    end
end

header(x::MixtureDatabase) = x.header
data(x::MixtureDatabase) = x.data
source(x::MixtureDatabase) = x.source
reference(x::MixtureDatabase) = x.reference
