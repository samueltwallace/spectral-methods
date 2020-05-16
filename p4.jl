using Plots

N=24 
h=2*π/N
x = h .* ([i for i=1:N])
D = zeros(N,N)

col = [ 0.5*(-1)^j*cot(j*h/2) for j=1:(N-1)]
col = vcat([0],col)
for i=N:-1:1
	D[:,i] = vcat(col[N-i+2:N],col[1:N-i+1])
end

u = exp.(sin.(x))
uprime = cos.(x) .* u
unicodeplots()
plot(x,u, show=true)
print("\n\n\n")
plot(x,uprime, show=true)
print("\n\n\n")
plot(x,D*u, show=true)

# TODO: NOT WORKING!!!
