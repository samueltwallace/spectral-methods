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
data = []
for q=qq
	e = eig(-D + 2*q*diag(cos.(2*x)))
	data = [data e]
end

unicodeplots()

plot(qq, data)
