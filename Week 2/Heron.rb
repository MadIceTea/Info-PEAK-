#This program calculates Heron's formula for any realistic lengths of triangle sides to give the triangle's area.

#Obligatory include math statement. Much like Java package import.
include(Math)

#Program piece
def heron(a,b,c)
   s = 0.5*(a+b+c)
   return sqrt(s*(s-a)*(s-b)*(s-c))
end