using Plots
using LinearAlgebra
include("cheb.jl")
include("meshgrid.jl")




N = 24
(D,x) = cheb(N)
y=x
xx,yy = meshgrid(x[2:N],y[2:N])

f = 10*sin.(8*xx .* (yy .- 1))
D2 = (D^2)[2:N,2:N]
identity = Diagonal([1 for i=1:(N-1)])
L = kron(identity,D2) + kron(D2,identity)
u = L\f

uu = zeros(N+1, N+1)
uu[2:N,2:N] = reshape(u, N-1, N-1)
gr()
plot(reverse(x),reverse(y),uu,st=:wireframe, camera=(180,70))
savefig("p16.png")
println("Done!")
