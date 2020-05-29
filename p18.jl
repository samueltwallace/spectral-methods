include("chebfft.jl")
using Plots
unicodeplots()


xx = -1:0.1:1
ff = exp.(xx).*sin.(5*xx)
for N=10:10:20
	x = cos.(π*(0:N)./N)
	f = exp.(x) .* sin.(5*x)
	plot(xx,ff, title="function" ,show=true)
	fakederiv = chebfft(f)
	println(typeof(chebfft))
	error = chebfft(f) .- exp.(x) .* (sin.(5*x)+5*cos.(5*x))
	plot(x,error,title="Error",show=true)
end
