load("./make2d_color.rb")

def cgradation(s)
    image = make2d_color(s, s)
    for y in 0..(s-1)
      for x in 0..(s-1)
       image[y][x][0] = (2.0*s-x-y)/(2*s)    
       image[y][x][1] = (1.0*s+x-y)/(2*s)
       image[y][x][2] = (1.0*s-x-y)/(2*s)
     end
    end
    image
end

