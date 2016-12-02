#This is the answer to functions problem set #2-b as coded by Alex TW.
#This program will determine the logarithim of logb(n) by calculation of log n / log b using included functions.

#obligatory statement for any Ruby-file mathematics program.
include(Math)

#Beginning of program code
def logsolver(base, number)
   b = log(base)
   a = log(number)
   return (a) / (b)
  end
  
#Example input that should make this program work:
#log(3, 9)