load("./make2d_color.rb")

def BoxImage(s)
  image = make2d_color(s,s)
  for x in 0..(s-1)
     for y in 0..(s-1)
        image[y][x]=[1,1,1] # paint white
       #If (x,y) is within some box, then paint purple
        if inBox(x,y,s/4,s/4,s/3,s/2)
           image[y][x]=[1,0,1]
        end
     end
   end
   image
end

def inBox(x,y,a,b,c,d)
    a<=x && x<=c && b<=y && y<=d
end