# Univariate optimization and root finding

I'll demonstrate with a few different packages.

First, we load the packages we'll need. In this case, that is only the plotting package:

    using Plots 

You should load all packages at beginning of file!
I just load the optimizers later to make it clear which package is being demonstrated.


## Function definition

    f(x) = x[1]^3 - x[1]

Let's plot it:

    xlim_low = -1.5
    xlim_high = 1.5
    plot1 = plot(f, xlim_low, xlim_high, label = "f(x)")
    plot1 = plot!(x -> 0, xlim_low, xlim_high, label = "")
    plot(plot1)


We will need an initial guess for every optimization algorithm:

    initial_value = -0.01

Plot the initial value:

    scatter!([initial_value],
            [0.],
            label = "Initial Value",
            markershape = :x)

## Optimization (Minimization)
### Optim Package
    using Optim
    optim_result = Optim.optimize(f, [initial_value], BFGS())

Display results and plot:

    print("Optim minimum: ")
    if optim_result.ls_success
        println(optim_result.minimizer)
        scatter!([optim_result.minimizer], [optim_result.minimum], label = "Optim minimum")
    else
        println("Failed to converge")
    end


## Root finding

### Roots Package
    using Roots
    roots_zero = find_zero(f, initial_value)

Display results and plot:

    println("Roots 'find_zero' zero: $(roots_zero)")
    scatter!([roots_zero],[f(roots_zero)], label = "Roots 'find_zero' zero")

Alternative syntax: 'fzero'

    roots_fzero_zero = fzero(f, initial_value)

Display results and plot:

    println("Roots 'fzero' zero: $(roots_fzero_zero)")
    scatter!([roots_fzero_zero],[f(roots_zero)], label = "Roots 'fzero' zero")


Another alternative syntax: 'solve'

    fx = ZeroProblem(f, initial_value)
    roots_solve_zero = solve(fx)

Display results and plot:

    println("Roots 'solve' zero: $(roots_solve_zero)")
    scatter!([roots_solve_zero],[f(roots_zero)], label = "Roots 'solve' zero")


### NLsolve Package
    using NLsolve
    f!(F, x) = F[1] = f(x)
    nls_zero = nlsolve(f!, [initial_value])

Display results and plot:

    println("NLsolve zero: $(nls_zero.zero)")
    scatter!([nls_zero.zero], [f(nls_zero.zero)], label = "NLsolve zero")

### LeastSquaresOptim
Nonlinear least squares, i.e. solves: 
$$min_{x} ~ f(x)ᵀf(x).$$

    using LeastSquaresOptim
    ls_optim_result = LeastSquaresOptim.optimize(f, [initial_value], Dogleg())

Display results and plot:

    print("LeastSquaresOptim minimum: ")
    if ls_optim_result.converged
        println("$(ls_optim_result.minimizer)")
        scatter!([ls_optim_result.minimizer], [f(ls_optim_result.minimizer)], label = "LeastSquaresOptim minimum")
    else
        println("Failed to converge")
    end
