using Plots
using FFTW

N = 128
h = 2*π/N
x = h.*[i for i=1:N]
t = 0
dt = h/4

c = (0.2).+(sin.(x.-1)).^2

v = exp.(-100* (x .-1).^2)
vold = exp.(-100 * (x .- (.2*dt +1)).^2)

# Time stepping

tmax = 8
tplot = 0.15
plotgap = round(tplot/dt)
dt = tplot/plotgap
nplots = round(Int64, tmax/tplot)
data = hcat(v, zeros(N,nplots))
tdata = t

for j=1:nplots
	for n=1:plotgap
		global t = t+dt
		v_hat = fft(v)
		w_hat = im.*[0:N/2-1; 0; -N/2+1:-1] .* v_hat
		w = real(ifft(w_hat))
		vnew = vold - (2*dt).*c.*w
		global vold = v
		global v = vnew
	end
	global data[:,j+1] = v
	global tdata = [tdata; t]
end
pyplot()
plot(x, tdata, data', st=:surface, camera=(10, 70), palette=cgrad(:grays), zlims=(1,5))
savefig("p6.png")
println("Done!")

