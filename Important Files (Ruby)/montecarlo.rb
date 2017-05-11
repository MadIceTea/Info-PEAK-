#This code is written by Alex T.W.

def montecarlo(n)
  m=0
  for i in 1..n
    x=rand() # random number in [0,1)
    y=rand()
    if x*x + y*y < 1.0
      m = m + 1
    end
  end
  return 4*m*1.0/n
end

def average(t,n)
	sum = 0
	for b in 0..t
		sum += montecarlo(n)
	end
x = sum / t
return x
end
	#An alternate method I am ambandoning
	# s = array.new(t)
	# for b in 0..t
		# s[b]=montecarlo(n)
	# end
    # v = 0
    # for i in s[1]..s[t]
        # v = v + i
    # end
    # v
	# c = v / t
	# c
	#end