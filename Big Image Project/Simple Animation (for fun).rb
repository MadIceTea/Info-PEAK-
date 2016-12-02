#The middle lines are very well drawn in the case of show circle(8,50).

include(Math)
load("./make2d.rb")

def radioactive(s,n)
 t = 2*s+1
 image = make2d(t,t)
	 for p in 0..(n-1)
	 theta = p*2*PI/n
	 y = t*(sin(theta))
	 x = t*(cos(theta))
	 image[y.to_i][x.to_i] = 1
	 show(image)
	 end
image
end