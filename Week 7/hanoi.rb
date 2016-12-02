def hanoi(n, a, b, c)
	if n==1
		print "Start at ", a, " and go to ", b, "/n"
	else
		hanoi(n-1, a, c, b)
		print "Start at ", a, " and go to ", b, "/n"
		hanoi(n-1, c, b, a)
	end
end