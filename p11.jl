include("cheb.jl")
using Plots

xx = -1:0.1:1
uu = exp.(xx) .* sin.(5*xx)

unicodeplots()
for N=10:10:20
	(D,x) = cheb(N)
	u = exp.(x).*sin.(5*x)
	plot(x,u)
	plot!(xx,uu,linetype=:scatter)
	plot!(title="f(x)")
	plot!(show=true)
	error = D*u - u - 5*exp.(x).*cos.(5*x)
	plot(x,error,linetype=:scatter)
	plot!(x,error)
	plot!(title="Error in f'(x)")
	plot!(show=true)
end
