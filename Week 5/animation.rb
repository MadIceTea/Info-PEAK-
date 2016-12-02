load("./make2d_color.rb")

def falling(s)
    image = make2d_color(s, s)
    for y in 0..(s-1)
        for x in 0..(s-1)
            image[y][x] = 1
        end
        show(image)
    end
    image
end

def quadratic(s)
    t=2*s+1
    image = make2d_color(t, t)
    u = 1.0*(t-2)/s**2
    print u
    for x in 0..(t-1)
        y = -u*(x-s)**2 + t-2 
        image[y][x] = 1
        show(image)
    end
    image
end

def hyperbola(s,a,b)
    t=2*s+1
    image = make2d_color(t, t)
    for y in 0..(t-1)
        x = a * sqrt(1.0*(y-s)**2/b**2 + 1)
        if x < t
          image[y][x.to_i] = 1
        end
        show(image)
    end
    image
end