#Final program to make everything work again - draw me a sphere!

load("./distance.rb")
load("./make2d.rb")

def b(r,x,y)
	if r >= dist(x,y)
	(r-(dist(x,y)))/r
	else r < dist(x,y)
	1
	end
 end

def sphere(r)
    image = make2d(2*r+1, 2*r+1)
    for y in 0..(2*r)
        for x in 0..(2*r)
            image[y][x] = b(r,x,y)
        end
    end
    show image
end