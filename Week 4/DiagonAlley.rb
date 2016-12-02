load("./make2d.rb")

def diagonal(s)
	image = make2d(s,s)
	for x in 0..(s-1)
	image [x][x]=1
	end
	image
end