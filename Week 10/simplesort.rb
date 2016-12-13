def simplesort(a)
  for i in 0..(a.length()-1)
    k = min_index(a,i)
    v = a[i]
    a[i] = a[k]
    a[k] = v
  end
  a
end

# version 1.3
# see http://lecture.ecc.u-tokyo.ac.jp/johzu/joho-kagaku/
