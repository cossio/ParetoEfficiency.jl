using Documenter, ParetoEfficiency

makedocs(
    modules=[ParetoEfficiency],
    sitename="ParetoEfficiency.jl"
)

deploydocs(
    repo = "github.com/cossio/ParetoEfficiency.jl.git",
    devbranch = "master"
)
