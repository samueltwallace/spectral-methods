using FFTW

function chebfft(v::Vector)
	N = length(v) - 1
	if N == 0
		w = 0
		return w
	end
	x = cos.((0:N).* (π/N))
	ii = 0:(N-1)
	V = [v; reverse(v[2:N])]
	U  = real(fft(V))
	W = real(ifft(im*[ii; 0; (1-N):-1] .* U))
	w = zeros(N+1,1)
	w[2:N] = -W[2:N] ./ sqrt.(1-x[2:N].^2)
	w[1] = sum(ii.^2 .*U[ii+1])/N + 0.5*N*U[N+1]
	w[N+1] = sum((-1).^(ii+1) .*ii.^2 .* U[ii+1])/N + 0.5*(-1)^(N+1)*N*U[N+1]
	return w
end
