using NLsolve

ϕ = 0.5
y = 1
β = 0.996
θ = 0.199
α = 0.4
s = 0.0225


function f!(F, v)
    ω = v[1]
    c = v[2]
    F[1] = (1-(1-ϕ)*α)*ω - ϕ*(y + θ*c)
    F[2] = θ^α*(1-β*(1-s))*c - β*(y-ω)
end

soln = nlsolve(f!, ones(2), autodiff = :forward)

@show soln.zero
