using LinearAlgebra
using Plots


N = 42
h = 2 * π / N
x = h*(1:N)

D = zeros(N,N)


col = [ 0.5*(-1)^j*cot(j*h/2) for j=1:(N-1)]
col = vcat([0],col)
for i=N:-1:1
	D[:,i] = vcat(col[N-i+2:N],col[1:N-i+1])
end


qq = 0:0.2:15
data = zeros(11,length(qq))
for i = 1:length(qq)
	q = qq[i]
	e = eigvals(-D + 2*q*Diagonal(cos.(2*x)))
	global data[:,i] = sort(imag.(e))[1:11]
end

pyplot()


plot(qq, data[1,:])
for i=2:11
	plot!(qq,data[i,:])
end
savefig("p21.png")
println("Done!")
