using Plots


x = 0:0.1:2*π
anim = @animate for n=1:0.1:2
	plot(x,sin.(n*x))
end

result = gif(anim, "sin.gif",fps = 30)

