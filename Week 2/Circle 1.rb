#This is the solution for functions problem #3-a as solved by Alex TW.

#This program will compute area of a circle.

#Obligatory math statement
include(Math)

#Prints instruction for user.
print("Input 'circle_a(x)' - length of the circle's radius")

#Coding segment
def circle_a(x)
     area = 3.141592653 * (x**2)
     return area
end