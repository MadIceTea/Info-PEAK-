# Sum of divisors of k in between 1 and n

load ("./divisible.rb")

def sod_loop(k,n)
    s = 0
    for i in 1..n
        if divisible(k,i)
            s = s + i
        end
    end
    s
end