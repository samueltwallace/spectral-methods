include("chebfft.jl")
using Plots


N = 80
x = cos.(π*(0:N)/N)
dt = 8/(N^2)

v = exp.(-200*(x.^2))
vold = exp.(-200*(x.-dt).^2)

tmax = 4
tplot = 0.075

plotgap = round(tplot/dt)
dt = tplot/plotgap
nplots = round(Int, tmax/tplot)

plotdata = v
tdata = 0


for i=1:nplots
	for n=1:plotgap
		w = chebfft(chebfft(v))
		w[1] = 0
		w[N+1] = 0
		vnew = 2*v - vold + (dt^2)*w
		global vold = v
		global v = vnew
	end
	global plotdata = [plotdata (v)]
	global tdata = [tdata; dt*i*plotgap]
end


pyplot()
plot((x), tdata, plotdata', st=:wireframe)
plot!(camera = (10,70), zaxis=(-2,2), xlabel="x", ylabel="t", zlabel="f")
savefig("p19.png")
println("Done!")
