using DifferentialEquations
using Plots
plotly()  # Use Plotly backend for interactive plots

## Forward Problem - Solving ODEs
# Define the Lotka-Volterra system
function lotka_volterra(u, p, t)
    x, y = u
    return [p.α*x - p.β*x*y, p.δ*x*y - p.γ*y]
end

# Initial conditions
u0 = [1.0, 1.0]

# Parameters: α, β, γ, δ
p = (α = 1.5, β = 1.0, γ = 3.0, δ = 1.0)

# Time span
tspan = (0.0, 20.0)

# Create and solve the ODE problem
prob = ODEProblem(lotka_volterra, u0, tspan, p)
sol = solve(prob)

# Generate Data
tData = 0:0.1:20
Data = sol(tData)
Data .+= 0.1 .* randn(size(Data))  # Add noise to the data

# Plot the solution
plot(sol, xlabel="Time", ylabel="Population", label=["Prey" "Predator"])
plot!(tData, Data', seriestype=:scatter, label=["Prey Data" "Predator Data"], markersize=3)

## Inverse Problem - Parameter Estimation
function loss(p)
    prob = ODEProblem(lotka_volterra, u0, tspan, p)
    sol = solve(prob, saveat=tData)
    return sum(abs2,(sol .- Data))  # Mean squared error
end 

# Optimize parameters using a simple gradient-free method
import Optimization as OPT
import OptimizationOptimisers, OptimizationOptimJL
import ForwardDiff, Zygote
import ComponentArrays as CA

p_init = (α = 1.3, β = 1.0, γ = 2.5, δ = 0.4) |> CA.ComponentArray  # Initial guess for parameters

adtype = Optimization.AutoZygote()  # Use Zygote for automatic differentiation
# adtype = Optimization.AutoForwardDiff()  # Use ForwardDiff for automatic differentiation
opt_func = OPT.OptimizationFunction((x,p) -> loss(p), adtype)
opt_prob = OPT.OptimizationProblem(opt_func, p_init)
result = solve(opt_prob, OptimizationOptimisers.Adam(), maxiters=1000)
# result = optimize(opt_prob, OptimizationOptimJL.LBFGS())
estimated_p = result.u
println("Estimated parameters: ", estimated_p)
