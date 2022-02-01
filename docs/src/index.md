# ParetoEfficiency.jl Documentation

*A simple Julia package to calculate the Pareto front of a set of points.*

This package only exports one function:

```@docs
ParetoEfficiency.pareto_front
ParetoEfficiency.strong_dominance
ParetoEfficiency.is_pareto_optimal
```

## Example

```@example
using ParetoEfficiency, CairoMakie

N = 1000
X = randn(N, 2)

fig = Figure(resolution=(640, 400))
ax = Axis(fig[1,1])
scatter!(ax, X[:,1], X[:,2], color=:black, markersize=4)

p = pareto_front(X[:,1], X[:,2])
scatter!(ax, X[p,1], X[p,2], label="pareto(+,+)", color=:red)

p = pareto_front(-X[:,1], X[:,2])
scatter!(ax, X[p,1], X[p,2], label="pareto(-,+)", color=:blue)

p = pareto_front(X[:,1], -X[:,2])
scatter!(ax, X[p,1], X[p,2], label="pareto(+,-)", color=:orange)

p = pareto_front(-X[:,1], -X[:,2])
scatter!(ax, X[p,1], X[p,2], label="pareto(-,-)", color=:green)

Legend(fig[1,2], ax)

fig
```