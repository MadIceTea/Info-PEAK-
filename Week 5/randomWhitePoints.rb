def randomWhitePoints(s,n)
load ("./make2d.rb")
    image = make2d(s,s)
    for i in 0..(n-1)
      y = rand(s)
      x = rand(s)
      image[y][x] = 1
    end
    image
end