#This is the solution to problem 3-5(c), giving the median of a set of three numbers, as solved by Alex TW.

include(Math)

def median(x,y,z)
 if x == y
 return y
 elsif y == z
 return y
 elsif x == z
 return x
 elsif x > y && y > z
 return y
 elsif x > y && y < z
 return x
 elsif y > x && y > z 
 return z
 else y > x && y < z
 return y
 end
end