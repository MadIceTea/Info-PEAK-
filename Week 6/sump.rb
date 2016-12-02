#This is the second problem of the programming exercises, Week 6. Part 2.
#Sum of multiples of p in between 1 and n
#This is the recursion.

def sump(p,n)
    if n >= 1
        if multiple(p,n)
            sump(p,n-1)+n
        else
            sump(p,n-1)
        end
    else
        0
    end
end