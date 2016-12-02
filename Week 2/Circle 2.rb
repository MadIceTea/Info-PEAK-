#This is the solution for functions problem #3-b as solved by Alex TW.
#WARNING: Requires that the user inputs that the radius is 10cm. Is not automatically assumed by the program.

#This program will compute area of a square equivalent to that of a cricle with radius 10cm.

#Obligatory math statement
include(Math)

#Prints instruction for user.
print("Input 'length(x)' - length of the circle's radius")

#Coding segment
def length(x)
     area = 3.141592653 * (x**2)
	 length_s = sqrt(area)
     return length_s
end