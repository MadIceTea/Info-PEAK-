def intcount(a,b,c)
	for i in 0..(a.length()-1)
		x = a[i]
		j = 0
		while b[j] !=0 && b[j] !=x
			j = j+1
		end
		if b[j] == 0
			b[j] = x
			c[j] = 1
		else
			c[j] = c[j] + 1
		end
	end
end