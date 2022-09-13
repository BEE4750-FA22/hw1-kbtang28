import Pkg
Pkg.activate(dirname(@__FILE__))
Pkg.instantiate()

using Plots
using Random
using Distributions

function yuk_treatment(X1, X2)
    mass = 100 - 0.8*X1 - (1-0.005*X2)*X2
    cost = X1^2/20 + 1.5*X2

    return mass, cost
end

n_treatment_samples = 2000
treatment_samples = rand(Dirichlet(ones(3)), n_treatment_samples) .* 100
treatment_output = yuk_treatment.(treatment_samples[1, :], treatment_samples[2, :])

mass = [o[1] for o in treatment_output]
cost = [o[2] for o in treatment_output]

scatter(mass, cost, xlabel="YUK discharge (kg/day)", ylabel="Treatment cost (\$\$)", legend=false, grid=false)
vline!([20], color=:red)

treatment_comply = treatment_samples[:, mass .< 20.0]

findmin(mass[mass .< 20.0])
min_mass_treatment = treatment_comply[:, 17]
min_mass_output = yuk_treatment(min_mass_treatment[1], min_mass_treatment[2])

findmin(cost[mass .< 20.0])
min_cost_treatment = treatment_comply[:, 12]
min_cost_output = yuk_treatment(min_cost_treatment[1], min_cost_treatment[2])

scatter(treatment_comply[1, :], treatment_comply[2, :], xlabel="X1 (m^3/d)", ylabel="X2 (m^3/day)", label=false, grid=false)
scatter!([min_mass_treatment[1]], [min_mass_treatment[2]], label="Minimum discharge")
scatter!([min_cost_treatment[1]], [min_cost_treatment[2]], label="Minimum cost")