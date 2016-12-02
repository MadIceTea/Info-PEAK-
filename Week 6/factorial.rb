#This is the first problem of the programming exercises, Week 6. Part 2.
#Factorial multiplication of the numbers from 1 to n
#This is the recursion.

def factorial(n)
if n >= 2
        factorial(n-1) * n 
    else
        1 
    end
end