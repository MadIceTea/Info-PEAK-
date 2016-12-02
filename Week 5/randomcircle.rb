include(Math)
load ("./make2d_color.rb")

def randomcircle(s)
a = rand(s)
b = rand(s)
r = rand(s)
c = [rand(),rand(),rand()]
image = make2d_color(s,s)
	for x in 0...(s-1)
	for y in 0...(s-1)
	image[y][x]=[0,0,0]
		if inCircle(x,y,a,b,r)
		image[y][x] = c
		end
	end
end

def inCircle(x,y,a,b,r)
(x-a)**2+(y-b)**2 <= r**2
end

image
end