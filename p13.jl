using Plots
include("cheb.jl")

N = 16
(D,x) = cheb(N)
D2 = D^2
D2 = D2[2:N,2:N]
f = exp.(4*x[2:N])
u = D2\f
u = [0; u; 0]

unicodeplots()
plot(x,u,show=true)
