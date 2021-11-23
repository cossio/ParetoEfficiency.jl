module ParetoEfficiency

export pareto_front

"""
    pareto_front(X)

Returns indices `i[1], i[2], ..., i[K]` of the Pareto optimal points.
Here `X` is a cost matrix, with the costs of point `i` along the row
`X[i,:]`.
"""
function pareto_front(X::AbstractMatrix)
    p = Int[]
    for i in 1:size(X, 1)
        if is_pareto_optimal(i, X)
            push!(p, i)
        end
    end
    return p
end

pareto_front(xs::AbstractVector...) = pareto_front(hcat(xs...))

"""
    strong_dominance(x, y)

Returns true if costs `x` dominate `y` in the Pareto sense.
"""
function strong_dominance(x::AbstractVector, y::AbstractVector)
    @assert length(x) == length(y)
    strict = false
    for (xi, yi) in zip(x, y)
        if xi > yi
            return false
        elseif xi < yi
            strict = true
        end
    end
    return strict
end

"""
    weak_dominance(x, y)

Returns true if costs `x` dominates `y` in the Pareto sense, or if `x == y`.
"""
function weak_dominance(x::AbstractVector, y::AbstractVector)
    @assert length(x) == length(y)
    for (xi, yi) in zip(x, y)
        if xi > yi
            return false
        end
    end
    return true
end

"""
    is_pareto_optimal(i, X)

Returns `true` if point `i` is Pareto optimal. Here `X` is a cost matrix, and the costs
of a point `j` are along the row `X[j,:]`.
"""
function is_pareto_optimal(i::Int, X::AbstractMatrix)
    return all(!strong_dominance(X[j,:], X[i,:]) for j in 1:size(X,1) if j ≠ i)
end

"""
    is_pareto_optimal(i, xs...)

Returns `true` if point `i` is Pareto optimal. Here `xs` are cost vectors.
The costs of point `i` are the list `[x[i] for x in xs]`.
"""
is_pareto_optimal(i::Int, xs::AbstractVector...) = is_pareto_optimal(i, hcat(xs...))

end # module
