#This is the solution for functions problem #4-b as solved by Alex TW.

#This program will compute volume of a tetrahedron.

#Obligatory math statement
include(Math)

#Prints instruction for user.
print("Input 'tetra(x)' - length of the side in a tetrahedron.")

#Coding segment
def tetra(x)
    volume = sqrt(2/3.0)*(sqrt(3.0)) * (x**3) * (0.5)
	return volume
end