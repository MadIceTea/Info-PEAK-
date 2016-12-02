# functions that compute Fibonacci sequence

def fibr(k)
    if k==0 || k==1
        1
    else
	fibr(k-1) + fibr(k-2)
    end
end

def fibl(k)
    f=1
    p1=1
    for i in 2..k
        p2 = p1      #fib(i-2)
        p1 = f       #fib(i-1)
        f  = p1 + p2 #fib(i)
    end
    f                #fib(k)
end

def fibl6(k)
    f=1
    p1=1
    for i in 2..k
        p2 = p1
        p1 = f
        f  = (p1 + p2) % 1000000
    end
    f
end


# version 1.6
# see http://lecture.ecc.u-tokyo.ac.jp/johzu/joho-kagaku/
