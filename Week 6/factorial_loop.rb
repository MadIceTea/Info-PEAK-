#This is the first problem of the programming exercises, Week 6. Part 1.
#Factorial multiplication of the numbers from 1 to n
#This is the repetition.

def factorial_loop(n)
    s = 1
    for i in 1..n
        s = s*i
    end
    s
end