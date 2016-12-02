#This is the solution to problem 3-7, detecting whether a,b,c (lengths of 3 sides) form the side lengths for a triangle.

include(Math)

def triangle(a, b, c)
  if a <= 0 || b <= 0 || c <= 0 || a+b <= c || b+c <=a || a+c <=b
    return "This triangle shall not pass."
  elsif a == b && a == c 
    return "I've got osteoporosis equilaterals."
  elsif a == b || a == c || b == c
    return "I've got isosceles depression."
  else 
    return "Oh my. That's a pretty good scalene!"
  end
end

#Credit to YouTube channel iDubbz for the osteopororosis-depression "hey that's pretty good meme" used.