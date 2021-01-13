abstract type PropertyDatabase end

name(db::PropertyDatabase) = error("Function not set for concrete type")
source(db::PropertyDatabase) = error("Function not set for concrete type")
reference(db::PropertyDatabase) = error("Function not set for concrete type")


"""
  ComponentDatabase(; name, source[, reference])

Registry of a database for pure components.

# Fields
- `name::AbstractString`: name of database. If database is used in `ComponentDatabaseSet`, `name` is used as primary key.
- `source::AbstractString`: path to source (raw) file. Usually, it is an absolute path to corresponding .csv file.
- `reference::AbstractString`: optional, scientific reference to database.
"""
struct ComponentDatabase <: PropertyDatabase
    name::AbstractString
    source::AbstractString
    reference::AbstractString

    function ComponentDatabase(;
            name,
            source,
            reference="no ref",
        )
        !isfile(source) && error("ComponentDatabase: Source file not found: $(source)")
        return new(name, source, reference)
    end
end

name(cdb::ComponentDatabase) = cdb.name
source(cdb::ComponentDatabase) = cdb.source
reference(cdb::ComponentDatabase) = cdb.reference


abstract type AbstractDatabaseSet end

"Returns collection of `<:PropertyDatabase` in the `db_set`."
databases(db_set::AbstractDatabaseSet) = error("Function not set for concrete type")

"""
  search(db_set, target_dbname)

Searches `db_set` for registry `<:PropertyDatabase` with `name` `target_dbname`.
Returns the registry.
Throws `DomainError`, if database registry is not found.

# Arguments
- `db_set::AbstractDatabaseSet`.
- `target_dbname::AbstractString`.
"""
function search(db_set::AbstractDatabaseSet, target_dbname::AbstractString)
    for db in databases(db_set)
        target_dbname == name(db) &&  return db
    end
    throw(DomainError(target_dbname, "not found in set `$(db_set)`"))
end

"""
  ComponentDatabaseSet(databases)

Registry of a set of databases.

# Arguments
- `databases::Vector{<:PropertyDatabase}`.
"""
struct ComponentDatabaseSet <: AbstractDatabaseSet
    databases::Vector{PropertyDatabase}

    function ComponentDatabaseSet(databases::Vector{<:PropertyDatabase})
        names = map(name, databases)
        if length(databases) != length(unique(names))
            error("ComponentDatabaseSet: names of databases are not unique")
        end
        return new(databases)
    end
end

databases(cds::ComponentDatabaseSet) = cds.databases
