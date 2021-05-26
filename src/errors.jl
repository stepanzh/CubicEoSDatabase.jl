"""
    CubicEoSDatabase.NotFoundError(what, where) <: Exception

Describes `where` `what` was not found. The `where` should be database object.
"""
struct NotFoundError <: Exception
    what
    where
end

Base.show(io::IO, x::NotFoundError) = begin
    print(typeof(x), "\nKeyword $(repr(x.what)) not found in $(x.where)")
end
