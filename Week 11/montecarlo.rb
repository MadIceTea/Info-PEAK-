def montecarlo(n)
  m=0
  for i in 1..n
    x=rand() # random number in [0,1)
    y=rand()
    if x*x + y*y < 1.0
      m = m + 1
    end
  end
  4*m*1.0/n
end

# version 1.2
# see http://lecture.ecc.u-tokyo.ac.jp/johzu/joho-kagaku/
