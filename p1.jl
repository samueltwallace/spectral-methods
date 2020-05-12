using Plots


Ns = [2^i for i=3:12]
matrixnums = [-2/3, 1/12, -1/12, 2/3]
errors = []

for N in Ns
	h = 2*π/N
	x = [- π + i*h for i in 1:N]
	u = exp.(sin.(x))
	uprime = u.* cos.(x)
	D = zeros(N,N)
	D[N,N]= -2/3
	D[N-1,N] = 1/12
	D[N,N-1] = 1/12
	for i=1:(N-2)
		D[i, i+2] = -1/12
		D[i,i+1] =2/3
	end
	D[N-1,N] = 2/3
	D = (D-D')/h

	push!(errors, max((D*u - uprime)...))
end
unicodeplots()
plot(Ns,errors,show=true)
