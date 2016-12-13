# This file defines a function random_array(id, size, max) that
# returns a random array with the given size.  Each element in the
# returned array is an integer between 0 (inclusive) to max
# (exclusive), or a real number between 0 and 1 when max==1.  It
# returns the same array when it provided the same set of parameters.

if !global_variables.index("$base_random_seed") || !$base_random_seed
  $base_random_seed = srand()
  $base_random_seed = srand()
end

def randoms(id, size, max)
  srand($base_random_seed + id)
  a = Array.new(size)
  for i in 0..(size-1)
    if max==1
      a[i]=rand()
    else
      a[i]=rand(max)
    end
  end
  a
end

# version 1.1
# see http://lecture.ecc.u-tokyo.ac.jp/johzu/joho-kagaku/
