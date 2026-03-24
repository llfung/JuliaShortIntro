using DifferentialEquations
using Plots
plotly()  # Use Plotly backend for interactive plots

## Ordinary Differential Equations (ODEs)
# Define the Lotka-Volterra system
function lotka_volterra(u, p, t)
    x, y = u
    α, β, γ, δ = p
    return [α*x - β*x*y, δ*x*y - γ*y]
end

# Initial conditions
u0 = [1.0, 1.0]

# Parameters: α, β, γ, δ
p = (1.5, 1.0, 3.0, 1.0)

# Time span
tspan = (0.0, 20.0)

# Create and solve the ODE problem
prob = ODEProblem(lotka_volterra, u0, tspan, p)
sol = solve(prob)

# Plot the solution
plot(sol, xlabel="Time", ylabel="Population", label=["Prey" "Predator"])

## Stochastic Differential Equations
function lotka_volterra_noise(u,p,t)
    x, y = u
    return [0.1*x, 0.1*y]  # Noise proportional to population size
end

stoc_prob = SDEProblem(lotka_volterra, lotka_volterra_noise, u0, tspan, p)
ensemble_prob = EnsembleProblem(stoc_prob)
sol_ensemble = solve(ensemble_prob, EM(), EnsembleThreads(), trajectories=100, dt=0.01)

plot(sol_ensemble, xlabel="Time", ylabel="Population", label=["Prey" "Predator"], alpha=0.1)