load("./make1d.rb")
load("./make2d.rb")

def make2d_color(height, width)
  a = Array.new(height)
  for i in 0..(height-1)
    a[i] = Array.new(width)
    for j in 0..(width-1)
       a[i][j] = make1d(3)
    end
  end
  a
end