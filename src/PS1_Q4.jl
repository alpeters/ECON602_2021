"""
    ECON 602 Problem Set 1 Question 4
"""

using Roots, Plots

function adequilibrium(π, γ, ωA, ωB, p_0)
    # solve for equilibrium price and consumption
    # p_0 is initial guess for numerical solver
    println("\n AD equilibrium:")
     @show π, γ, ωA, ωB;

    f(p, π, γ, ωA, ωB) = π*(ωA[1] + p*ωB[1]) + 1/(1 + p*(p*π/(1-π))^(-1/γ))*(ωA[2] + p*ωB[2]) - ωA[1] - ωA[2]
    cA(p, π, γ, ωA, ωB) = [π*(ωA[1] + p*ωB[1]), 1/(1 + p*(p*π/(1 - π))^(-1/γ))*(ωA[2] + p*ωB[2])]
    cB(p, π, γ, ωA, ωB) = [(1 - π)/p * (ωA[1] + p*ωB[1]), 1/(p + (p*π/(1 - π))^(1/γ))*(ωA[2] + p*ωB[2])]

    # It never hurts to plot and see what you're working with
    plot(p -> f(p, π, γ, ωA, ωB), 0, 4)
    plot!(x -> 0, 0, 4)
    
    @show p_star = fzero(p -> f(p, π, γ, ωA, ωB), p_0);
    #=
     The first argument, p -> f(p, π, γ, ωA, ωB), defines and 'anonymous'
     function of only p. It is a 'wrapper' for the function f that assigns
     the values to all other parameters as they are currently defined.
    =#
    
    @show cA = cA(p_star, π, γ, ωA, ωB);
    @show cB = cB(p_star, π, γ, ωA, ωB);
    return (p_star = p_star, cA = cA, cB = cB)  
end

function adequilibrium_alt(π, γ, ωA, ωB, p_min, p_max)
    println("\n AD equilibrium (alternative function):")
    # solve for equilibrium price and consumption
    # alternative syntax and solution algorithm using bounds
    @show π, γ, ωA, ωB;

    f(p, π, γ, ωA, ωB) = π*(ωA[1] + p*ωB[1]) + 1/(1 + p*(p*π/(1-π))^(-1/γ))*(ωA[2] + p*ωB[2]) - ωA[1] - ωA[2]
    cA(p, π, γ, ωA, ωB) = [π*(ωA[1] + p*ωB[1]), 1/(1 + p*(p*π/(1 - π))^(-1/γ))*(ωA[2] + p*ωB[2])]
    cB(p, π, γ, ωA, ωB) = [(1 - π)/p * (ωA[1] + p*ωB[1]), 1/(p + (p*π/(1 - π))^(1/γ))*(ωA[2] + p*ωB[2])]

    # It never hurts to plot and see what you're working with
    plot(p -> f(p, π, γ, ωA, ωB), p_min, p_max)
    plot!(x -> 0, p_min, p_max)
    
    # Alternative to anonymous function
    f(p) = f(p, π, γ, ωA, ωB)
    #=
     Note that this is a distinct function from the first 
     function I defined, as it has a different number of
     arguments
    =#
    @show p_star = fzero(f, p_min, p_max);
    #=
     This provides an allowable range for solutions between
     0.01 and 4, rather than a single initial guess. This 
     can be useful to prevent the algorithm from searching
     for negatives prices for example.
    =#
    
    @show cA = cA(p_star, π, γ, ωA, ωB);
    @show cB = cB(p_star, π, γ, ωA, ωB);
    return (p_star = p_star, cA = cA, cB = cB);
end

# q4e
ωA = [2, 5];
ωB = [5, 2];
γ = 2;
π = 0.5;
q4e = adequilibrium(π, γ, ωA, ωB, 1.1);
q4e_alt = adequilibrium_alt(π, γ, ωA, ωB, 0.01, 10.);

# q4f
ωA = [2, 5];
ωB = [5, 2];
γ = 2;
# π = 0.25
π = 0.25;
q4f_π025 = adequilibrium(π, γ, ωA, ωB, 1.1);
# π = 0.75
π = 0.75;
q4f_π075 = adequilibrium(π, γ, ωA, ωB, 1.1);
