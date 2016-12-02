def circle(s, n)
    t=2*s+1
    image = make2d(t, t)
    for x in 0..(n-1)
        theta = x*2*PI/n
        y = (Fill in this part)
        x = (Fill in this part)
        image[y.to_i][x.to_i] = 1
        show(image)
    end
    image
end
