def randompoints(s, n)
    image = make2d_color(s, s)
    for i in 0..(n-1)
      y = rand(s)
      x = rand(s)
      image[y][x] = [rand(),rand(),rand()]
    end
    image
end
