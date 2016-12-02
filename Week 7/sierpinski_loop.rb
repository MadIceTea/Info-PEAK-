#This is the solution to the first exercise, Week 7.

load("./make2d.rb")
load("./Sierpinski_rec.rb")

def sierpinski_loop(n)
	c = make2d(n+1,n+1)
	for i in 0..n
		c[i][0] = 1
		for j in 1..(i-1)
			c[i][j] = ((c[i-1][j-1] + c[i-1][j]) % 2)
		end
		c[i][i] = 1
	for j in 0...n
		c[i][j] = 1 - c[i][j]
	end
	end
	c
end