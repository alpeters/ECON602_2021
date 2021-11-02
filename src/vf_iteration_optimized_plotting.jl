using Plots
using BenchmarkTools

function vfsolveplot(vnew, kgrid, tolerance, imax)
    α = 0.3
    δ = 0.1
    β = 0.9

    display(plot(kgrid, vnew, label = "V0"))
    # display(plot(kgrid, kgrid, label = "k'0"))
    sleep(2)
    v = vnew .+ 2*tolerance
    kprime = zeros(n)
    i = 1
    while maximum(abs.(v - vnew)) > tolerance && i <= imax
        v = vnew;
        c = kgrid.^α + (1-δ)*kgrid .- kgrid'
        c[c .< 0] .= 0
        (vnew, cartesianindex) = findmax(log.(c) .+ β*v', dims = 2);
        kprimeindex = getindex.(cartesianindex, 2)
        kprime = kgrid[kprimeindex]
        i % 5 == 0 ? display(plot!(kgrid, vnew, label = "V$i")) : nothing
        # i % 5 == 0 ? display(plot!(kgrid, kprime, label = "k'$i")) : nothing
        sleep(1)
        i += 1;
    end
    return (v = vnew, kprime = kprime, kprimeindex = kprimeindex)
end


kupper = 2
klower = 0.001
n = 100
kgrid = collect(range(klower, stop = kupper, length = n))
(v, kprime, kprimeindex) = vfsolveplot(zeros(n), kgrid, 0.001, 1000);