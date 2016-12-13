load("./randoms.rb")    # randoms(id,size,max)
load("./simplesort.rb") # simplesort(a)
load("./mergesort.rb")  # mergesort(a)

def compare_sort2(max, step)
  print "size\t simplesort \t mergesort\n"
  for i in 1..(max/step)
    x=i*step
    print x, "\t"
    a=randoms(i,x,1)

    t = Time.now # time before execution
    simplesort(a)
    print Time.now-t, "\t"

    t = Time.now # time before execution
    mergesort(a)
    print Time.now-t, "\n"
  end
end

