#This is the second problem of the programming exercises, Week 6. Part 1.
#Sum of multiples of p in between 1 and n
#This is the repetition.

load ("./multiple.rb")

def sump_loop(p,n)
	s=0
	for i in 1..n
		if multiple(p,i)
			s=s+i
		end
	end
	s
end