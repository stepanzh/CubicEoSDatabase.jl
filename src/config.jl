"""
Database configuration file.

Here presents

# Constants
- `DBROOT`: absolute path to directory containing source files.
- `LOADASC5`: constant marking components with carbon number ≥ 5 in source files.

# Database sets
- `PHYSCOMPDBS::ComponentDatabaseSet`: contains databases with physical paramateres (critical temperature, acentric factor...) of pure components.
- `PHYSMIXDBS::ComponentDatabaseSet`: not implemented. Same as `PHYSCOMPDBS`, but for mixtures.
- `EOSCOMPDBS::ComponentDatabaseSet`: contains databases with paramateres defining equation of state for pure components.
- `EOSBMIXDBS::ComponentDatabaseSet`: same as `EOSCOMPDBS`, but for mixtures.
"""

"Absolute path to directory containing source files"
const DBROOT = abspath(@__FILE__, "../../data/")

"Marking components with carbon number ≥ 5 in source files"
const LOADASC5 = "C5+"

#####
##### Database sets configuration
#####

##### Physical paramateres of pure components and mixtures

# пути к файлам бд по физическим параметрам чистых веществ
PHYSCOMPDBS = ComponentDatabaseSet([
    ComponentDatabase(name="martinez",
        source=joinpath(DBROOT, "phys/comp", "martinez.csv"),
        reference=joinpath(DBROOT, "src/gas-parameters-martinez.pdf"),
    ),
])

# пути к файлам бд по физическим параметрам смесей
# PHYSMIXDBS = ComponentDatabaseSet([])

##### Equation of state paramateres of components and mixtures.

# пути к файлам бд по параметрам уравнения состояния чистых веществ
EOSCOMPDBS = ComponentDatabaseSet([
    ComponentDatabase(name="brusylovsky",
        source=joinpath(DBROOT, "eos/comp", "brusylovsky.csv"),
        reference="Брусиловский (2002) Т:4.14 C:213"
    ),
])

# пути к файлам бд по параметрам бинарных взаимодействий
# для уравнений состояния смесей
EOSBMIXDBS = ComponentDatabaseSet([
    ComponentDatabase(name="brusylovsky",
        source=joinpath(DBROOT, "eos/mix", "brusylovsky.csv"),
        reference="Брусиловский (2002) Т:4.22 C:255 (лин. 1е-3)"
    ),
    ComponentDatabase(name="pr",
        source=joinpath(DBROOT, "eos/mix", "pr.csv"),
        reference="Брусиловский и др. (1992) Т:2.8 С:57"
    ),
])
