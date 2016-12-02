#Sub-program to help run the loop program.

load("./make1d.rb")
load("./make2d.rb")

def sierpinski_rec(n)
   a = make2d(2**n, 2**n)
   subsierpinski(a, n, 0, 0)
   a
end

def subsierpinski(a, n, x, y)
   if n == 0
     a[y][x] = 1
   else
     subsierpinski(a, n-1, x, y)
     subsierpinski(a, n-1, x, y + 2**(n-1))
     subsierpinski(a, n-1, x + 2**(n-1), y + 2**(n-1))
   end
end