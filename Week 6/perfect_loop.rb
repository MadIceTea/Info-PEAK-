#The main formula for finding perfect numbers (as a formula): 2**(p−1)*((2**p)−1)
#The above will be made into a seperate file for the purposes of the rest of this code.
#This is the beginning of problem 3 for Week 6. Part 1 - repetition.
#This is perfectly functional code.

load ("pnum.rb")

def perfect_loop(p)
	s = 0
	for i in 2..p-1
		if p % i != 0
			j = s + pnum(p)
		end
	end
	j
end