def combination(n,k)
    if k > n
        0
    else
      if k == 0
          1     
      else
          combination(n-1,k-1) + combination(n-1,k)
      end
    end
end
