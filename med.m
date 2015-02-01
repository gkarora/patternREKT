function class = med(x,z)
    x_size = size(x,1);
    
    distances = [];
    for n = 1:x_size
        y = x(n,:);
        z_distance = norm(y-z);
        distances = [distances z_distance];
    end
    
    min_distance = min(distances);
    class = find(distances==min_distance);
end