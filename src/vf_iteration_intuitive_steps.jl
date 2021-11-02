α = 0.3
δ = 0.1
β = 0.9


kupper = 2
klower = 0.001
n = 10
kgrid = collect(range(klower, stop = kupper, length = n))
v = zeros(length(kgrid))

c = zeros(n, n)
for i in 1:n
    for j in 1:n
        c[i,j] = kgrid[i]^α + (1-δ)*kgrid[i] - kgrid[j]
    end
    # vnew = maximum(log.(c) .+ β*v, dims = 2)
end

c

using Plots
heatmap(kgrid, kgrid, c, dims = 2,
        xlab = "k prime",
        ylab = "k",
        xmirror = true,
        yflip = true)



## Fixing negative consumption problem
vnew = Array{Float64, n}
c = zeros(n, n)
for i in 1:n
    for j in 1:n
        c[i,j] = kgrid[i]^α + (1-δ)*kgrid[i] - kgrid[j]
        if c[i,j] <= 0
            c[i,j] = 10^-10
        end
    end
    vnew = maximum(log.(c) .+ β*v', dims = 2)
end

heatmap(kgrid, kgrid, c, dims = 2,
        xlab = "k prime",
        ylab = "k",
        xmirror = true,
        yflip = true)

scatter(kgrid, vnew)

## Iterate
tolerance = 0.001
imax = 1000
vnew = zeros(length(kgrid))
v = vnew .+ 2*tolerance
global cartesianindex = Array{CartesianIndex{2}, n}
i = 1
while maximum(abs.(v - vnew)) > tolerance && i<=imax
    v = vnew;
    c = zeros(n, n);
    for i in 1:n
        for j in 1:n
            c[i,j] = kgrid[i]^α + (1-δ)*kgrid[i] - kgrid[j];
            if c[i,j] <= 0
                c[i,j] = 10^-10;
            end
        end
        # vnew = maximum(log.(c) .+ β*v', dims = 2);
        (vnew, cartesianindex) = findmax(log.(c) .+ β*v', dims = 2);
    end
    i += 1
end

scatter(kgrid, vnew, title = "v(k)")

kprimeindex = getindex.(cartesianindex, 2)
kprime = kgrid[kprimeindex]
scatter(kgrid, kprime, title = "k'(k)")


