using LinearAlgebra
using Plots
include("cheb.jl")



N = 24
(D,x) = cheb(N)
y=x
xx = repeat(x[2:N], size(y[2:N])...)
yy = repeat(y[2:N], size(x[2:N])...)

f = exp.(-10*((yy.-1).^2 + (xx .-5).^2))
D2 = (D^2)[2:N,2:N]
identity = Diagonal([1 for i=1:(N-1)])
k=9
L = kron(identity, D2) + kron(D2,identity) + k^2*I

u = L\f
uu = zeros(N+1,N+1)
uu[2:N,2:N] = reshape(u,N-1,N-1)
gr()
plot(reverse(x),reverse(y),uu,st=:wireframe,camera = (25, 65))
savefig("p17.png")
println("Done!")
