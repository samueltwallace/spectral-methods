using Plots
using LinearAlgebra.I
include("cheb.jl")




N = 24
(D,x) = cheb(N)
y=x
xx = repeat(x, size(y)...)
yy = repeat(y, size(x)...)

f = 10*sin(8*xx .* (yy .- 1))
D = (D^2)[2:N,2:N]
L = kron(I,D2) + kron(D2,I)
u = L\f

uu = zeros(N+1, N+1)
uu[2:N,2:N] = reshape(u, N-1, N-1)
pyplot()
plot(xx,yy,uu,st=:surface)
savefig("p16.jl")
println("Done!")
