"""
Низкоуровневые функции для работы с БД
"""

"""
    ismet(conds, subject)

Проверяет массив `subject` на удовлетворение условий `conds`.
Массив условий представляет собой паттерн для поиска нужной строки.
Если какой-то столбец не важен, используйте `missing`.
Массив условий обязан быть длиной не больше, чем проверяемый.

Условия выбраны в виде массива, чтобы можно было обращаться одновременно и к базам
данных по одиночным вещества и по смесям (требуют несколько столбцов).

# Аргументы
- `conds::AbstractVector`: массив условий. Состоит из строк или `missing`
- `subject::AbstractVector`: массив строк на проверку удовлетворения `conds`

*Из-за неувязок c minCSV.Reader пока нельзя уточнить тип `subject` :c*

# Примеры
```julia-repl
julia> ismet(["methane"], ["methane", "0.01604276", "1", "191", "4600000", "0.01", "0.288"])
true
julia> ismet(["methane", "propane"], ["methane", "propane", "0.019", "0.000502", "0"])
true
julia> ismet(["ABC", "missing", "CDE"], ["abc", "smth", "CDE", "smth else"])
false
julia> ismet(["ABC", "ABC"], ["ABC"])
ERROR: Массив условий превышает проверяемый массив
...
```
"""
function ismet(conds::AbstractVector, subject::AbstractVector)
    length(conds) > length(subject) && error("Массив условий превышает проверяемый массив")
    all(ismissing(c) || c == s for (c, s) in zip(conds, subject))
end

"""
    get_first_row(r, conds)

Возвращает первую строку, удовлетворяющую `conds`.
Если такой строки нет, возвращает пустой массив `[]`.

# Аргументы
- `r::minCSV.Reader`: объект, поддерживающий итерирование и возвращающий массив строк. На данный момент поддержка только для `::minCSV.Reader`
- `conds::AbstractVector`: см.`ismet()`
"""
function get_first_row(r::Reader, conds::AbstractVector)
    for row in r
        if ismet(conds, row)
            return row
        end
    end
    return []
end
