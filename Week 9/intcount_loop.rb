a = [10,9,8,8,6,6,6,3,3,2,2,1]
b = [0,0,0,0,0,0,0]
c = [0,0,0,0,0,0,0]

def intcount_sort(a,b,c)
j = -1
for i in 0..(a.length() - 1)
x = a[i]
if x == a[i-1]
c[j] = c[j] + 1
		else
			j = j + 1
			b[j] = x
			c[j] = 1
		end
		end
	end
	
intcount_sort(a,b,c)
print b
print c