def intcount_loop(a,b,c)
	for i in 0..(a.length()-1)
		x = a[i]
		j = 0
		for j in 0…(b.length()-1)
			if b[j] == 0
				b[j] = x
			else
				b[j] = b[j] +1
			end
			if b[j] != 0 || b[j] != x
				c[j] = 1
			else
			c[j] = c[j] + 1
			end
		end
	end
end