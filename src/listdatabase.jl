# возвращает ширину столбцов csv-файла
function column_width(fname)
    io = open(fname)
    reader = Reader(io, sep=',', quotechar='"')
    width = map(length, readrow(reader))
    for row in reader
        for i in eachindex(row)
            width[i] = max(width[i], length(row[i]))
        end
    end
    close(io)
    return width
end

function list_database_entries(db, indent="    ")
    field_sep = " "^2
    io = open(source(db))
    reader = Reader(io, sep=',', quotechar='"')
    width = column_width(source(db))
    for entry in reader
        print(indent)
        for (i, field) in enumerate(entry)
            if i != length(entry)
                print(field, " "^(width[i]-length(field)), field_sep)
            else  # last field without trailing characters
                print(field)
            end
        end
        println()
    end
    close(io)
end

function print_database_set(dbset::AbstractDatabaseSet)
    for (i, db) in enumerate(databases(dbset))
        println("database $(i)")
        println("       name: ", name(db))
        println("source file: ", source(db))
        println("  reference: ", reference(db))
        println("    entries:")
        list_database_entries(db)
        println()
    end
end

"""
  list_database()

Распечатывает базу данных.
"""
function list_database()
    databases = (
        (PHYSCOMPDBS, "physics of pure components"),
        (EOSCOMPDBS, "eos parameters of pure components"),
        (EOSBMIXDBS, "eos parameters of mixtures"),
    )

    for (dbset, purpose) in databases 
        println("database set: ", purpose)
        print_database_set(dbset)
    end
end
