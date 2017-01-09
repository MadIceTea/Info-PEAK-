# This code is written by Alex T.W., with quite some assistance from StackOverflow user "unj2".
#It is meant to answer exercise 2 question of Week 10, Prof. Kakimura's Information class.
# In the interest of not plagarizing, I would like to say that in my confusion I looked up this topic on StackOverflow and came across this page (https://stackoverflow.com/questions/855693/is-there-a-better-way-to-find-the-location-of-a-minimum-element-in-an-array) with rather inspiring code.

def min_index(a,i)
	minimum = 0
	for i in 1..(a.length())
		if array[i]<array[0]
			minimum = i
		end
	end
return minimum
end

def simplesort(a)
  for i in 0..(a.length()-1)
	k = min_index(a,i)
    v = a[i]
    a[i] = a[k]
    a[k] = v
  end
  a
end

#This should allow for simplesort method sorting of a positive number array (I might need to find a more foolproof method with negative numbers.)