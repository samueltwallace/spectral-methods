using Plots

N=24 
h=2*π/N
x = h .* ([i for i=1:N])
D = zeros(N,N)
for i=1:(N-1)
	for j=1:i
		if i % 2 ==0
			D[N - i + j, j] = 1/2* cot(j*h/2)
		else
			D[N - i + j, j] = -1/2* cot(j*h/2)
		end
	end
end
D = D - D'

u = exp.(sin.(x))
uprime = cos.(x) .* u
unicodeplots()
plot(x,u, show=true)
print("\n\n\n")
plot(x,uprime, show=true)
print("\n\n\n")
plot(x,D*u, show=true)

# TODO: NOT WORKING!!!
