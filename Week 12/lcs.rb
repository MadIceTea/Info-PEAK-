load("./make2d.rb")

def lcs(s, t)
 m = s.length()
 n = t.length()
 a = make2d(n+1, m+1)
 for i in 0..m
 a[0][i] = 0
 end
 for j in 0..n
 a[j][0] = 0
 end
 for i in 1..m
 for j in 1..n
 if s[i-1..i-1] == t[j-1..j-1]
 p = 1
 else
 p = 0
 end
 a[j][i] = max3( p + a[j-1][i-1], a[j-1][i], a[j][i-1])
 end
 end
 a[n][m]
end
def max3(p,q,r)
 max(p, max(q,r))
end
def max(p,q)
 if p>q
 p
 else
 q
 end
end