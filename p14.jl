using LinearAlgebra
using Plots
include("cheb.jl")



N=16
(D,x) = cheb(N)
D2 = D^2
D2 = D2[2:N,2:N]
u = zeros(N-1,1)
change = 1
it = 1
while change > 1e-15
	unew = D2\exp.(u)
	global change = norm(unew - u)
	global u = unew
	global it += 1
end

u = [0; u; 0]
unicodeplots()
plot(x,u,show=true)
