using Plots
using BenchmarkTools

function vfsolve(vnew, kgrid, tolerance, imax)
    α = 0.3
    δ = 0.1
    β = 0.9

    v = vnew .+ 2*tolerance
    cartesianindex = Array{CartesianIndex{2}, length(v)}
    i = 1
    
    c = kgrid.^α + (1-δ)*kgrid .- kgrid'
    c[c .< 0] .= 0
    u = log.(c)
    u[kgrid.^α + (1-δ)*kgrid .- kgrid' .< 0] .= -Inf

    while maximum(abs.(v - vnew)) > tolerance && i <= imax
        v = vnew;
        
        (vnew, cartesianindex) = findmax(u .+ β*v', dims = 2);
        i += 1;
    end
    kprimeindex = getindex.(cartesianindex, 2)
    return (v = vnew, kprime = kgrid[kprimeindex], kprimeindex = kprimeindex)
end


kupper = 2
klower = 0.001
n = 1000
kgrid = collect(range(klower, stop = kupper, length = n))
(v, kprime, kprimeindex) = vfsolve(zeros(n), kgrid, 0.001, 1000);

scatter(kgrid, v, label = "v")
scatter(kgrid, kprime, label = "k'")

# Checks
vbasic == v
kprimebasic == kprime

@btime vfsolve(zeros(n), kgrid, 0.001, 1000);
@btime vfsolvebasic(zeros(n), kgrid, 0.001, 1000);

# Check k bounds, stepsize, tolerance, imax
findall(kprime .== maximum(kgrid))
any(kprime .== minimum(kgrid))

plot()
kupper = 2
klower = 0.001
for tolerance in [0.001, 0.0005]
    for n in [10, 100, 500]
        kgrid = collect(range(klower, stop = kupper, length = n))
        (v, kprime, kprimeindex) = vfsolve(zeros(n), kgrid, tolerance, n);
        display(plot!(kgrid, v, label = "v, n=$n, tol=$tolerance"))
        # display(plot!(kgrid, kprime, label = "k'"))
    end
end