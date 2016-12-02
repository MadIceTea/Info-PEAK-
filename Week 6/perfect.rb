#The main formula for finding perfect numbers (as a formula): (2**(p−1))*((2**p)−1)
#The above will be made into a seperate file for the purposes of the rest of this code.
#This is the beginning of problem 3 for Week 6. Part 2 - recursion.
#This is a non-functional program, and I realised that I would not spend any more time on it when I noticed that it was not a required part of the assignment.

load ("pnum.rb")

def perfect(p)
    for i in 2..(p-1)
        if p % i != 0  
           pnum(p)
        else
           pnum(p-1)
        end
    end
end