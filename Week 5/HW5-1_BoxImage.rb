#This starts the embedded box problem (Problem 1) in Week 5.
#This program has been optimized for the input of "BoxImageHw(8)".

load("./make2d_color.rb")

def BoxImageHw(s)
  image = make2d_color(s,s)
  for x in 0..(s-1)
     for y in 0..(s-1)
        image[y][x]=[1,0,0] # paint red
       #If (x,y) is within some box, then paint white or light blue
        if inBox(x,y,s/5,s/5,s/1.25,s/3)
          image[y][x]=[1,1,1] #paints white
		end
		if inBox(x,y,s/5,s/2.5,s/1.25,s/1.5)
           image[y][x]=[0,1,1] #paints light blue
		end
     end
   end
image
end
   
def inBox(x,y,a,b,c,d)
    a<=x && x<=c && b<=y && y<=d
end