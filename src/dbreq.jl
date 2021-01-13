"""
Содержит top-level функции с запросами к базе данных по компонентам и смесям.
"""

"""
    gcp(from_db::AbstractString, cname::AbstractString)

`gcp` - get component's physics.

Возвращает `Dict` с физическими параметрами компонента.

# Аргументы
- `from_db::AbstractString`: название базы данных по физическим параметрам компонентов, указанное в конфигурационном файле
- `cname::AbstractString`: название компонента, значение поля `name` в соответствующем файле БД

# Возвращаемое значение
```julia
Dict(
    "name"      =>  String( component name ),
    "mass"      => Float64( molar mass, kg/mol ),
    "ctemp"     => Float64( critical temperature, K ),
    "cpres"     => Float64( critical pressure, Pa ),
    "acentr"    => Float64( acentric factor ),
    "ccompres"  => Float64( critical supercompressibility ),
    "ncarb"     => Int
)
```
"""
function gcp(from_db::AbstractString, cname::AbstractString)
    source_file = source(search(PHYSCOMPDBS, from_db))
    
    f = open(source_file)
    r = Reader(f, sep=',', quotechar='"')
    property_index = get_first_row(r, ["name"])  # номер строки заголовков
    raw = get_first_row(r, [cname])
    close(f)
    
    @debug "gcp" from_db source_file cname "$(raw)"

    if isempty(raw)
        throw(DomainError(cname, "component not found in `$from_db` physical DB ($source_file)"))
    end

    #   process raw data and construct Dict
    #   raw = [name, molmass, crittemp, critpres, acentric, critsupercompress]
    return Dict(
        "name" => raw[1],
        (
            alias => parse(T, raw[findfirst(==(p), property_index)]) for (alias, p, T) in
            (
                ("mass", "molecular_mass", Float64),
                ("ctemp", "critical_temperature", Float64),
                ("cpres", "critical_pressure", Float64),
                ("acentr", "acentric_factor", Float64),
                ("ccompres", "critical_compressibility", Float64),
                ("ncarb", "number_carbons", Int)
            )
        )...
    )
end

"""
    gce(eosname, cname)

`gce` - get component's eos parameters.

Возвращает `Dict` с параметрами уравнения состояния компонента.
В случае С5+ веществ возвращает словарь с теми же ключами, но в значениях будет стоять
значение конфигурационной константы `LOADASC5::String`.

# Аргументы
- `eosname::AbstractString` название базы данных с параметрами уравнения состояния, указанное в конфигурационном файле;
- `cname::AbstractString` название компонента, обычно это значение поля `name` в соответствующем файле БД.

# Возвращаемое значение
```julia
Dict(
    "name"      =>  String( component name ),
    "ccompres"  => Float64( parametric critical supercompressibility z*_C ) xor LOADASC5,
    "comega"    => Float64( Omega_C parameter ) xor LOADASC5,
    "psi"       => Float64( psi parameter ) xor LOADASC5
)
```
"""
function gce(eosname::AbstractString, cname::AbstractString)
    source_file = source(search(EOSCOMPDBS, eosname))

    f = open(source_file)
    r = Reader(f, sep=',', quotechar='"')
    property_index = get_first_row(r, ["name"])
    raw = get_first_row(r, [cname])
    close(f)

    if isempty(raw)
        throw(DomainError(cname, "component not found in `$eosname` EoS DB ($(source_file))"))
    end

    #   raw = [name, critsupercompress, critomega, psi]
    #   в raw лежат либо числа, либо пометка, что для вещества надо использовать
    #   параметры группы С5+, во втором случае пометка просто оставляется
    return Dict(
        "name"      => raw[1],
        (alias => let idx = findfirst(==(p), property_index)
         raw[idx] != LOADASC5 ? parse(Float64, raw[idx]) : LOADASC5
         end
         for (alias, p) in (("ccompres", "critical_compressibility"),
                            ("comega", "critical_omega"),
                            ("psi", "psi")))...
    )
end

"""
    gbie(eosname, cname_1, cname_2[, cname_3...])

`gbie` - get binary interaction eos parameters.

Возвращает матрицы `constant_ij`, `linear_ij`, `quadratic_ij` бинарных взаимодействий из БД `eosname`.

Матрицы квадратные, симметричные, на диагонали нули.
Элемент `M[i, j]` соответствует коэффициенту для компонентов `cname_i`, `cname_j`.


# Аргументы
- `eosname::AbstractString`: название, указанное в конфигурационном файле, базы данных по параметрам уравнения состояния
- `cname_i::AbstractString`: названия компонентов
"""
function gbie(eosname::AbstractString, cnames::AbstractString...)
    length(cnames) < 2 && error("You must specify more than 1 component")

    source_file = source(search(EOSBMIXDBS, eosname))
    N = length(cnames)

    found_pairs = fill(false, (N, N))

    constant = fill(0.0, (N, N))
    linear = copy(constant)
    quadratic = copy(constant)

    pair_counter = 0
    pairs_must_be = (N * (N-1)) ÷ 2
    
    # перебор пар
    for i in eachindex(cnames)
        for j in eachindex(cnames)
            i == j && continue  # диагональ пропускаем, она нулевая
            @debug "gbie" cnames[i] cnames[j] pair_counter pairs_must_be

            # запрос
            f = open(source_file)
            r = Reader(f, sep=',', quotechar='"')
            raw = get_first_row(r, [cnames[i], cnames[j]])
            close(f)

            if !isempty(raw)
                pair_counter += 1
                found_pairs[i, j] = found_pairs[j, i] = true
                 constant[i, j] =  constant[j, i] = parse(Float64, raw[3])
                   linear[i, j] =    linear[j, i] = parse(Float64, raw[4])
                quadratic[i, j] = quadratic[j, i] = parse(Float64, raw[5])
            end
            pair_counter == pairs_must_be && break
        end
    end

    @debug "gbie" constant linear quadratic

    if pair_counter != pairs_must_be
        println("Some pairs are not present in `$(eosname)`. They marked by `N` in table below. Discard diagonal.")
        println(" \t", join(1:N, " "))
        for i in 1:N
            println("$i\t", join(map(x -> x ? "Y" : "N", found_pairs[i, :]), " "))
        end
        println("where:")
        for (i, c) in enumerate(cnames)
            println("  $i is `$c`")
        end
        throw(DomainError(cnames, "Can't find some pairs in database. See table above."))
    end

    return constant, linear, quadratic
end
