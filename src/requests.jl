"""
    getentry(from::AbstractTabularDatabase{1}, key::AbstractString)

Searches database `from` for row (entry) with first item equal to `key`.

Returns `Dict` which keys are `header(from)` and values are corresponding data.
"""
function getentry(from::AbstractTabularDatabase{1}, key::AbstractString)
    for row in eachrow(data(from))
        if first(row) == key
            return Dict(
                k => v for (k, v) in zip(header(from), row)
            )
        end
    end
    throw(NotFoundError(key, from))
end

"""
    getentry(from::AbstractTabularDatabase{2}, key₁, key₂[; keeporder])

Searches database `from` for row (entry) which first two items are equal to `key₁` and `key₂`.

If `keeporder` is `true` then the keys are assumed to be ordered pair (default is `false`).

Returns `Dict` which keys are `header(from)`, and values are corresponding data.
"""
function getentry(
        from::AbstractTabularDatabase{2},
        key₁::AbstractString,
        key₂::AbstractString
        ;
        keeporder=false
    )
    for row in eachrow(data(from))
        if (row[1] == key₁ && row[2] == key₂) || (!keeporder && row[1] == key₂ && row[2] == key₁)
            return Dict(
                k => v for (k, v) in zip(header(from), row)
            )
        end
    end
    throw(NotFoundError((key₁, key₂), from))
end

"""
    getmatrix(from::AbstractTabularDatabase{2}, keys[; diag])

Extracts matrices from `from` by **unordered** key pairs generated from `keys`.

Each matrix corresponds to a data column in `from`.
The matrices are symmetric with diagonal elements `diag=0.0`.

Indices of a matrix are same as in `keys`.

Returns `Dict` which keys are `header(from)` and values are matrices.

# Arguments

- `keys`: collection, must support `eachindex` method
"""
function getmatrix(
        from::AbstractTabularDatabase{2},
        keys
        ;
        diag=0.0
    )
    N = length(keys)
    result = Dict(k => fill(diag, (N,N)) for k in Base.Iterators.rest(header(from), 3))

    pair_counter = 0
    pairs_must_be = (N * (N-1)) ÷ 2

    for i in eachindex(keys)
        for j in eachindex(keys)
            i == j && continue  # skip diagonal

            entryᵢⱼ = getentry(from, keys[i], keys[j])

            for k in Base.keys(result)
                pair_counter += 1
                result[k][i, j] = result[k][j, i] = entryᵢⱼ[k]
            end
            pair_counter == pairs_must_be && break
        end
    end
    return result
end
