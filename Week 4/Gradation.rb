#This problem is meant to be the basis for any necessary shading.

def gradation(s)
	image = make2d(s,s)
	for y in 0..(s-1)
		for x in 0..(s-1)
			 image [y][x]=(2.0*s-x-y)/(2*s)
		end
	end
	image
end