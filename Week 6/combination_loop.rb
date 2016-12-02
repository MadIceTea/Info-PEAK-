load("./make2d.rb")

def combination_loop(n,k)
  c=make2d(n+1,n+1)
  for i in 0..n
    c[i][0] = 1
    for j in 1..(i-1)
      c[i][j] = c[i-1][j-1] + c[i-1][j] 
    end
    c[i][i] = 1
  end
  c[n][k]
end

# version 1.1
# see http://lecture.ecc.u-tokyo.ac.jp/johzu/joho-kagaku/
