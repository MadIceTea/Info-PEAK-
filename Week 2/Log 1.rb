#This is the answer to functions problem set #2-a as coded by Alex TW.
#This program will determine the logarithim of log_3(n) by calculation of log n / log 3 using included functions.

#obligatory statement for any Ruby-file mathematics program.
include(Math)

#Beginning of program code
def log3(n)
   a = log(n)
   b = log(3)
   return a / b
end