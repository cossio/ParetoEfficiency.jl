using Test: @test, @testset
import ParetoEfficiency
using ParetoEfficiency: strong_dominance, weak_dominance, is_pareto_optimal, pareto_front

N = 1000
X = randn(N, 3)

for i in 1:N, j in i:N
    @test weak_dominance(X[i,:], X[j,:])  == all(X[i,:] .≤ X[j,:])
    @test strong_dominance(X[i,:], X[j,:]) == (all(X[i,:] .≤ X[j,:]) && any(X[i,:] .< X[j,:]))
end

p = pareto_front(X)

# all points in p are not dominated by anybody else
for k in p, j in 1:N
    @test !strong_dominance(X[j,:], X[k,:])
end

# p includes all dominant points
for k in 1:N
    is_dominant = true
    for j in 1:N
        if strong_dominance(X[j,:], X[k,:])
            is_dominant = false
            break
        end
    end
    @test is_pareto_optimal(k, X) == is_dominant
    @test is_pareto_optimal(k, X) == is_pareto_optimal(k, eachcol(X)...)
    if is_dominant
        @test k ∈ p
    end
end
