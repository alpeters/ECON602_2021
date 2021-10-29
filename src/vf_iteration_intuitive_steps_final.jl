using Plots

# Problem parameters
α = 0.3
δ = 0.1
β = 0.9

# Capital grid
kupper = 2
klower = 0.001
n = 10
kgrid = collect(range(klower, stop = kupper, length = n))

# Iteration parameters
tolerance = 0.001
imax = 1000

# Initialize values
vnew = zeros(length(kgrid)) # initial value function guess
v = vnew .+ 2*tolerance # initialize v in a way that ensures loop will start
global cartesianindex = Array{CartesianIndex{2}, n}
i = 1

while maximum(abs.(v - vnew)) > tolerance && i<=imax
    v = vnew;
    c = zeros(n, n);
    for i in 1:n
        for j in 1:n
            c[i,j] = kgrid[i]^α + (1-δ)*kgrid[i] - kgrid[j];
            if c[i,j] <= 0
                c[i,j] = 0;
            end
        end
        (vnew, cartesianindex) = findmax(log.(c) .+ β*v', dims = 2);
    end
    i += 1
end

scatter(kgrid, vnew, title = "v(k)")

# Policy function
kprimeindex = getindex.(cartesianindex, 2)
kprime = kgrid[kprimeindex]
scatter(kgrid, kprime, title = "k'(k)")


