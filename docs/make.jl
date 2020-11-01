using MzCore
using Documenter

makedocs(;
    modules=[MzCore],
    authors="Tim Holy <tim.holy@gmail.com> and contributors",
    repo="https://github.com/timholy/MzCore.jl/blob/{commit}{path}#L{line}",
    sitename="MzCore.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://timholy.github.io/MzCore.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/timholy/MzCore.jl",
    devbranch="main",
)
