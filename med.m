function class = med(x,z)
    min_distance = 100;
    closest_class =[];
    x_size = size(x);
    row_size = x_size(1);

    for n = 1:row_size
        y = x(n,:);
        distance = norm(y-z);
        if distance<min_distance;
            closest_class = x(n,:);
            min_distance = distance;
        end
    end
    class = closest_class;
end