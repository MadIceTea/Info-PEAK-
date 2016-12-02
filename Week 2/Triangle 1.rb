#This is the solution for functions problem #4-a as solved by Alex TW.

#This program will compute area of an equilateral traingle.

#Obligatory math statement
include(Math)

#Prints instruction for user.
print("Input 'triangle(x)' - length of the side of an equilateral triangle")

#Coding segment
def triangle(x)
    area = (sqrt(3)) * (x**2) * (0.5)
	return area
end