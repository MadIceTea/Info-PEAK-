# the greatest divisor of k in between 1 to n
load("./divisible.rb")

def gd_loop(k,n)
    while !divisible(k,n)
        n = n-1
    end
    n
end
# version 1.2
# see http://lecture.ecc.u-tokyo.ac.jp/johzu/joho-kagaku/
