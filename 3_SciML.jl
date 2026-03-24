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
tspan = (0.0, 10.0)

# Create and solve the ODE problem
prob = ODEProblem(lotka_volterra, u0, tspan, p)
sol = solve(prob)

# Generate Data
tData = 0:0.1:10
Data = sol(tData) |> Array
Data .+= 1.0 .* randn(size(Data))  # Add noise to the data

# Plot the solution
plot(sol, xlabel="Time", ylabel="Population", label=["Prey" "Predator"])
plot!(tData, Data', seriestype=:scatter, label=["Prey Data" "Predator Data"], markersize=3)

## Inverse Problem - Parameter Estimation
function loss(p, (tData, Data))
    prob_ = ODEProblem(lotka_volterra, u0, tspan, p)
    sol_ = solve(prob_, saveat=tData)
    return sum(abs2,(sol_ .- Data))  # Mean squared error
end 

# Optimize parameters using a simple gradient-free method
import Optimization as OPT
import OptimizationOptimisers, OptimizationOptimJL
import SciMLSensitivity
import ForwardDiff, Zygote
import ComponentArrays as CA


p_init = (α = 1.7, β = 1.5, γ = 4.1, δ = 0.9) |> CA.ComponentArray  # Initial guess for parameters

# adtype = OPT.AutoZygote()  # Use reverse mode for automatic differentiation
adtype = OPT.AutoForwardDiff()  # Use forward mode for automatic differentiation

opt_func = OPT.OptimizationFunction(loss, adtype)
opt_prob = OPT.OptimizationProblem(opt_func, p_init, (tData, Data))
result = OPT.solve(opt_prob, OptimizationOptimisers.Adam(), maxiters=10000)
# result = OPT.solve(opt_prob, OptimizationOptimJL.NewtonTrustRegion()) 
estimated_p = result.u
println("Estimated parameters: ", estimated_p)

# Learnt result
prob_result = ODEProblem(lotka_volterra, u0, tspan, estimated_p)
sol_result = solve(prob_result)

plot!(sol_result, line=:dash, label=["Learnt Prey" "Learnt Predator"])
