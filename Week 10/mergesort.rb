#This code is written by Alex T.W.

load("./is_even.rb")
load("./make2d.rb")
#Creative re-use of make2d's array nature to call the new array with make2d instead of the more regular term, array.new

def merge(a,b) #Important to know a and b are already sorted.
  c = make1d(a.length()+b.length())
  ia=0	
  ib=0
  ic=0
  while ia < a.length() && ib < b.length()
    if a[ia] < b[ib]
      c[ic] = a[ia]
      ia = ia + 1
      ic = ic + 1
    else
      c[ic] = b[ib]
      ib = ib + 1
      ic = ic + 1
    end
  end
  c+a+b #Take what you know have of c + a or b, the blank one + the other of a or b, the one with the remainder of your sorted terms.
  c
end

def mergesort(a)
  n = a.length()
  from = make2d(n,1)
  for i in 0..(n-1)
    from[i][0] = a[i] 
  end
  while n > 1
    to = make1d((n+1)/2)
    for i in 0..(n/2-1)
      to[i] = merge(from[i*2], from[i*2+1])
    end
    if !is_even(n)
      to[(n+1)/2-1]=from[n-1]
    end
    from=to
    n=(n+1)/2
  end
  from[0]
end