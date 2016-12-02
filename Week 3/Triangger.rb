#This is the solution to problem 3-7, detecting whether a,b,c (lengths of 3 sides) form the side lengths for a triangle, as written by Alex TW.

include(Math)

def triangle(a, b, c)
  if a <= 0 || b <= 0 || c <= 0 || a+b <= c
    return "This triangle shall not pass."
  else 
    return "This too shall pass a triangle."
  end
end