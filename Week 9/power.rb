def power_loop(a, n)
    s = 1
    for i in 1..n
        s = s * a
    end
    s
end
def power_r(a, n)
    if n == 0
        1
    else
        a*power_r(a, n-1)
    end
end
def power2(a, n)
    if n == 0
        1
    elsif n%2 == 0
         (power2(a, n/2))**2
    else
         a*power2(a, n-1)
    end
end
def power_loop6(a, n)
    s = 1
    for i in 1..n
        s = (s * a)%100000
    end
    s
end
def power_r6(a, n)
    if n == 0
        1
    else
        a*(power_r6(a, n-1)%100000)
    end
end
def power26(a, n)
    if n == 0
        1
    elsif n%2 == 0
         (power26(a, n/2)%100000)**2
    else
         a*(power26(a, n-1)%100000)
    end
end
