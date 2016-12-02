def VennDiagram(s)
 image = make2d_color(s,s)
 for x in 0..(s-1)
   for y in 0..(s-1)
      # paint white
      image[y][x]=[1,1,1]
#     (Fill in this part using inCircle)
  end
 end
 image
end
def inCircle(x,y,a,b,r)
  (x-a)**2+(y-b)**2 <= r**2
end
