# JuliaShortIntro
A Short Introduction to Julia. 

## Set up
1. [Download](https://julialang.org/install/) and Install Julia
2. Open VSCode and Install Julia extension
3. Set up a local virtual environment
   1. Open a Julia REPL (Alt+J Alt+O)
   2. Press `]` (Go into Package Manager)
   3. Type `Activate venv` (This creates a virtual env. `venv`)
   4. Now install some packages by typing `add {Pkg name}`
      - Package used: `] add DifferentialEquations, Plots, PlotlyBase, PlotlyKaleido, Optimization, OptimizationOptimJL, OptimizationOptimisers, ForwardDiff, Zygote, ComponentArrays, SciMLSensitivity, DifferentiationInterface`
  
## Content
0. Introduction to JULIA
1. Why JULIA? - Some key features
2. Demo - Solving ODEs and SDEs with [DifferentialEquations.jl](https://docs.sciml.ai/DiffEqDocs/stable/)
3. Demo - Solving inverse problem with the [SciML ecosystem](https://sciml.ai)

## A few important keyboard shortcuts in VSCode
Julia file is sectioned by lines with `##` in front

Open a Julia REPL by Alt+J Alt+O

Run the section by Alt+Enter

Run a single line by Ctrl+Enter

## Further Material
- [Julia's official website](https://julialang.org/learning/)
- DoggoDotJL's [YouTube Channel](https://www.youtube.com/@doggodotjl)
