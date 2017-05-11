def submatch(s,i,p,w)
  j = 0
  while j < w && s[(i+j)..(i+j)] == p[j..j]
  #Check if some j<w in position of array until we match end of the given array to the end of the possible array positions.
    j = j + 1
  end
  j
end

#submatch is rather simple

def match(s,p)
  i=0
  w=p.length() #w is how long the search substring is
  while submatch(s,i,p,w) < w #check submatch and compare to given  bove
    i = i + 1
  end
  i
end

#nah fam copyright is outdated anyway :P