function class = med(x,z)
    min_distance = 100;
    closest_class = 1;
    x_size = size(x,1);

    for n = 1:x_size
        y = x(n,:);
        distance = norm(y-z);
        if distance<min_distance;
            closest_class = n;
            min_distance = distance;
        end
    end
    class = closest_class;
end