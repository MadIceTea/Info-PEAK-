# Calculates the direct distance between any pair of 2-tuple coordinate points, as written by Alex TW.

#Obligatory include math statement to "import the math package" (java terminology) into this program.
include(Math)

def dist(x,y,u,v)
sqrt(((u-x)**2)+((v-y)**2))
end

# Example shown below.
#dist(1,2,3,4)