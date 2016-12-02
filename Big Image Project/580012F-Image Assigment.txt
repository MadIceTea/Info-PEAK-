#Large Take-Home Image Assignment
#Title:Domo In Japan **during starry night**
#Illustrated by: Alexander Taniguchi, 580012F
#Submitted 2 Dec 2016
#Tested with parameters (512,12000),(512,4000),(900,12000), but as all measurements are relative it should be fine with any size, pref. s>=100.
#s=canvas size (makes square canvas s*s pixels)
#n=number of nice coloured random points in the background, not to exceed s**2

load ("./make2d_color.rb")

def domo(s,n)
    image = make2d_color(s,s)
    for i in 0..(n-1)
      y = rand(s)
      x = rand(s)
      image[y][x] = [rand(),rand(),rand()]
    end
	for s in 0..s/2
      y = rand(s)
      x = rand(s)
      image[y][x] = [rand(),rand(),rand()]
    end
  for x in (s/35)..(s)
     for y in (s/35)..(s)
       image[y][x]=[0.65,0.45,0.1] #brown blackground
        if inBox(x,y,s/5.5,s/1.6,s/1.2,s/1.1)
           image[y][x]=[1,0,0] #paints red
			   if inCircle(x,y,s/5.5,s/1.6,s/60)
			   image[y][x]=[0.65,0.45,0.1] #paints brown
			   end
			   if inCircle(x,y,s/1.2,s/1.6,s/60)
			   image[y][x]=[0.65,0.45,0.1] #paints brown
			   end
			   if inCircle(x,y,s/5.5,s/1.05,s/18)
			   image[y][x]=[0.65,0.45,0.1] #paints brown
			   end
			   if inCircle(x,y,s/1.2,s/1.05,s/18)
			   image[y][x]=[0.65,0.45,0.1] #paints brown
			   end
			   if inCircle(x,y,s/1.95,s/1.05,s/7)
			   image[y][x]=[1,1,1] #paints white
			   end
		end
		if inCircle(x,y,s/6,s/6,s/8)
          image[y][x]=[0,0,0] #paints black
		end
		if inCircle(x,y,s/2,s/2.2,s/16)
          image[y][x]=[0,1,1] #paints white
		end
		if inCircle(x,y,s/1.25,s/6,s/8)
          image[y][x]=[0,0,0] #paints black
		end
     end
   end
	for x in (s-s/5)..(s+(s/1.1))
		for y in (s+s/12)..(s+(s/1.1))
		image[y][x]=[1,1,1]
			if inCircle(x,y,(6.8/5*s),(7.5/5*s),s/4)
			image[y][x]=[1,0,0]
			end
		end
	end
	image
end

def inCircle(x,y,a,b,r)
(x-a)**2+(y-b)**2 <= r**2
end

def inBox(x,y,a,b,c,d)
    a<=x && x<=c && b<=y && y<=d
end