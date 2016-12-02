#This is the problem 3-10(a), in which we use the && operator for divisibility, as written by Alex TW.

def print_divnum(n)
  for i in 1..n
  if (i % 7 == 0) && (i % 3 != 0)
	print "Value that passed the test is #{i}. \n"
  else
    print("This entry has not failed, but has not yet passed either. \n")
  end
  end
end