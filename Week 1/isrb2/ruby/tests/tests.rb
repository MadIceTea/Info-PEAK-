#-------------------------------------------------------------------------------
# Copyright (c) 2012 Hidehiko Masuhara.
# All rights reserved. This program and the accompanying materials
# are made available under the terms of the GNU Public License v3.0
# which accompanies this distribution, and is available at
# http://www.gnu.org/licenses/gpl.html
# 
# Contributors:
#     Hidehiko Masuhara - initial API and implementation
#
# $Id: tests.rb,v 1.7 2012/10/01 09:21:39 masuhara Exp $
#-------------------------------------------------------------------------------

# to show a 2x2 B&W image, and then changes the intensity of the
# top-left pixel after 3 seconds.
def test1
  $a = [[0,1],[1,0]]
  show($a)
  sleep 3
  $a[0][0] = 0.5
end

# to show a large image of size 400x400
def test2(size = 400)
  puts "building an array"
  $b = Array.new(size) { |y| Array.new(size) { |x|
      d = ((y-size/2)**2+(x-size/2)**2)**0.5
      (d > size/2) ? 0 : (d / (size/2))
    }
  }
  puts "calling show..."
  start = Time.new
  show($b)
  finish = Time.new
  puts "#{finish - start} seconds to show"
end

# to show an image larger than 400x400
def test3
  test2(500)                    # FIXME: no image shown right now
end

# to set pixels in a large image of size 400x400
def test4(size = 400)
  puts "building an array"
  $c = Array.new(size){ Array.new(size,0) }
  show($c)
  start = Time.new
  for y in 0..$c.length-1
    for x in 0..$c[0].length-1
      d = ((y-size/2)**2+(x-size/2)**2)**0.5
      $c[y][x] = (d > size/2) ? 0 : (d / (size/2))
    end
  end
  finish = Time.new
  puts "#{finish - start} seconds to set"
end

# to show a colorful image
def test5
  $d = [[[1,0,0],[0,1,0],[0,0,1]],
        [[0,0.5,1],[1,0,0.5],[0.5,1,0]],
        [[0.7,0.5,1],[1,0.7,0.5],[0.5,1,0.7]],
       ]
  show($d)
end

# to show non-square image
def test6
  $e = [[1,0,1,0,1,0]]
  show($e)
  show($e.transpose)
end



# to show in an existing frame when show is applied to the same array twice
def test7
  a = [[1,0],[0,1]]
  show(a)
  frame = a[0].instance_variable_get(:@isrb_frame).getContainingWindow
  show(a)
  frame2 = a[0].instance_variable_get(:@isrb_frame).getContainingWindow
  if frame != frame2
    raise "shown in two windows!?"
  end
end

# to update the frame by assignments to a color image
def test8
  a = [[ [0,0,0] ]]
  show(a)
  a[0][0] = [1,0,0]             # should update the frame

  b = [[ [0,0,0] ]]
  show(b)
  b[0][0][1] = 1             # should update the frame
end                          # you will see red and green boxes

# to show a color image of size 400x400
def test9(size = 400, show_before=false)
  puts "building an array"
  $c = Array.new(size){ Array.new(size) { [0,0,0] } }
  start = Time.new
  if show_before then
    show($c)
    shown = Time.new
    puts "#{shown - start} seconds to show (before)"
  else
    shown = start
  end
  
  for y in 0..$c.length-1
    for x in 0..$c[0].length-1
      d = ((y-size/2)**2+(x-size/2)**2)**0.5
      $c[y][x] = [x*1.0/size, y*1.0/size,
                  (d > size/2) ? 0 : (d / (size/2))]
    end
  end
  mid = Time.new
  puts "#{mid - shown} seconds to build"
  show($c)
  finish = Time.new
  puts "#{finish - mid} seconds to show (after)"
end

# if show is called on the same array twice, it should show the frame
# even after the firstly shown frame is manually colsed
#
# TODO: the second frame won't accept keyboard shortcuts
def test10
  $a = [[0,1],[1,0]]
  show($a)
  puts "close the window!"
  gets
  $a[0][0] = 0.75
  $a[0][1] = 0.25
  $a[1][0] = 0.25
  $a[1][1] = 0.75
  show($a)
end

# to show a color image of size 400x400
def test11(size = 400, show_before=false)
  puts "building an array"
  $c = Array.new(size){ Array.new(size) { 0 } }
  start = Time.new
  if show_before then
    show($c)
    shown = Time.new
    puts "#{shown - start} seconds to show (before)"
  else
    shown = start
  end
  
  for y in 0..$c.length-1
    for x in 0..$c[0].length-1
      d = ((y-size/2)**2+(x-size/2)**2)**0.5
      $c[y][x] =  (d > size/2) ? 0 : (d / (size/2))
    end
  end
  mid = Time.new
  puts "#{mid - shown} seconds to build"
  show($c)
  finish = Time.new
  puts "#{finish - mid} seconds to show (after)"
  $c[0][0]
  puts "#{Time.new - finish} seconds to reference (after)"
end

# to show an animation
def test12(color=false, size=100, frames=30)
  $a = Array.new(size){ Array.new(size) { color ? [0,0,0] : 0 } }
  dx = dy = 1.0/size
  di = 1.0/frames
  for i in 0..frames-1
    for y in 0..size-1
      for x in 0..size-1
        $a[y][x] = color ? f12c(x*dx,y*dy,i*di) : f12g(x*dx,y*dy,i*di)
      end
    end
    show($a)
  end
end

include(Math)

def f12c(x,y,i)
  d = ((x-0.5)**2 + (y-0.5)**2)**0.5
  [ (cos(2*PI*(x*4-i*2))+1)/2,
    (cos(2*PI*(y*2*(2+cos(2*PI*i))))+1)/2,
    (cos(2*PI*(d-i))+1)/2 ]
end

def f12g(x,y,i)
  d = ((x-0.5)**2 + (y-0.5)**2)**0.5
  (cos(2*PI*(d-i))+1)/2
end

# to show one-dimensional array
def test13
  show([0,1,0,1])
end

def test14
  a = [[0,1],[1,0]]
  show(a).equal?(a) or
    raise "show(a) should return a"
end

# element update will cause image update even for a one-dimensional array
def test15
  a = [0,1,0,1]
  show(a)
  a[0]=1
end
