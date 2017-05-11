#This code is written by Alex T.W.

load("./montecarlo.rb")
def spherecarlo(n,r)
  m=0
  for i in 1..n
    x=rand() # random number in [0,1)
    y=rand()
    if x*x + y*y < 1.0
      m = m + 1
    end
  end
  return (4.0/3.0)*(4*m*1.0/n)*(r**3)
end

def savage(t,n,r)
	sum = 0
	for b in 0..t
		sum += spherecarlo(n,r)
	end
x = sum / t
return x
end