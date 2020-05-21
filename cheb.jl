using LinearAlgebra

function cheb(N::Int64)
	if N==0
		D = 0
		x = 1
		return (D,x)
	end
	x = cos.((0:N).* (π/N))
	c = [2; ones(N-1,1); 2] .* (-1).^(1:N+1)
	X = repeat(x,1,N+1)
	dX = X-X'
	D = (c*(1 ./c)')./(dX+I)
	D = D - Diagonal(vec(sum(D',dims=1)'))
	return (D,x)
end
