#This is the solution to problem 3-3(a), giving the boolean divisibility of a number, as solved by Alex TW.

include(Math)

def divisible(x,y)
 if x%y == 0
 return print "Yes. Divisibility is OK."
 else
 return print "No. Your divisibility will not pass."
 end
end