load("./make1d.rb")
def make2d(height,width)
  a = Array.new(height)
  for i in 0..(height-1)
    a[i] = make1d(width)
  end
  a
end
