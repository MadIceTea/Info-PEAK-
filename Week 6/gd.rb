# the greatest divisor of k in between 1 to n
load("./divisible.rb")

def gd(k,n)
    if divisible(k,n)
        n
    else
        gd(k,n-1)
    end
end
# version 1.2
# see http://lecture.ecc.u-tokyo.ac.jp/johzu/joho-kagaku/
