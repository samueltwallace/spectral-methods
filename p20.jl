using Plots
using FFTW
include("chebfft.jl")
include("meshgrid.jl")

# Grid and initial data
N = 24
x = cos.((0:N)*(π/N))
y = x'
dt = 6/N^2
xx,yy = meshgrid(x,y)
plotgap = round(1/(3*dt))
dt = 1/(3*plotgap)
vv = exp.(-40*((xx .- .4).^2 + yy.^2))
vvold = vv

# Time-stepping by leap frog formula

ay,ax = meshgrid([0.5 0.6], [0.1 0.55])

pyplot()


for n =0:3*plotgap
	t = n*dt
	if (n+0.5) % plotgap < 1
		i = n/plotgap + 1
		plot(x,y,vv,camera=(10,80),st=:surface, zaxis=(-2,2))
		savefig("p20" * string(i) * ".png")
	end
	uxx = zeros(N+1, N+1)
	uyy = zeros(N+1,N+1)
	ii = 2:N
	for i=2:N
		v = vv[:,i]
		V = [v; reverse(v[ii])]
		U = real(fft(V))
		W1 = real(ifft(im*[0:(N-1) 0 (1-N):-1].*U))
		W2 = real(ifft(- [0:N (1-N):-1].^2 .* U))
		uxx[i,ii] = W2[ii]./(1-x[ii].^2) - x[ii].*W1[ii]./(1-x[ii].^2).^(3/2)
	end
	for j = 2:N
		v = vv[j,:]
		V = [v; reverse(v[ii])]
		U = real(fft(V))
		W1 = real(ifft(im*[0:(N-1) 0 (1-N):-1].* U))
		W2 = real(ifft(- [0:N (1-N):-1].^2 .* U))
		uyy[j,ii] = W2[ii]./(1-y[ii].^2) - y[ii].* W1[ii]./(1-y[ii].^2).^(3/2)
	end
	vvnew = 2*vv - vvold + dt^2 * (uxx + uyy)
	global vvold = vv
	global vv = vvnew
end
