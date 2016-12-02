#This starts the Circle Animation problem (Problem 2) in Week 5.
#There should be a lesson in why lines 11 and 12 must start with the "s-" part.
#This took me about an hour to figure out finally.
#When you see the difference after an hour, you might feel like this guy "https://www.youtube.com/watch?v=aZHvd0ks7Es"
#Sample image included was ran at circle(100,2016)

include(Math)
load ("./make2d.rb")

def circle(s,n)
 t = 2*s+1
 image = make2d(t,t)
	 for p in 0..(n-1)
	 theta = p*2*PI/n
	 y = s-(0.5*t*(sin(theta)))
	 x = s-(0.5*t*(cos(theta)))
	 image[y.to_i][x.to_i] = 1
	 show(image)
	 end
image
end