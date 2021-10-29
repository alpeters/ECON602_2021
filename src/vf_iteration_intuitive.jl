using Plots

function vfsolvebasic(vnew, kgrid, tolerance, imax)
    α = 0.3
    δ = 0.1
    β = 0.9

    n = length(kgrid)
    v = vnew .+ 2*tolerance
    cartesianindex = Array{CartesianIndex{2}, n}
    i = 1
    while maximum(abs.(v - vnew)) > tolerance && i<=imax
        v = vnew;
        c = zeros(n, n);
        for i in 1:n
            for j in 1:n
                c[i,j] = kgrid[i]^α + (1-δ)*kgrid[i] - kgrid[j];
                if c[i,j] < 0
                    c[i,j] = 0
                end
            end
            (vnew, cartesianindex) = findmax(log.(c) .+ β*v', dims = 2);
        end
        i += 1
    end
    kprimeindex = getindex.(cartesianindex, 2)
    return (v = vnew, kprime = kgrid[kprimeindex], kprimindex = kprimeindex)
end


kupper = 2
klower = 0.001
n = 10
tolerance = 0.001
imax = 1000
kgrid = collect(range(klower, stop = kupper, length = n))
(vbasic, kprimebasic, kprimeindex) = vfsolvebasic(zeros(n), kgrid, tolerance, imax)

# Check it agrees with previous version
scatter(kgrid, vbasic, label = "v")
scatter!(kgrid, vnew, label = "v")

scatter(kgrid, kprime, label = "k'")
scatter!(kgrid, kprimebasic, label = "k'")

vbasic == vnew
kprimebasic == kprime