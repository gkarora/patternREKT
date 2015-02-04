function [ class ] = nn_2( x, data_a, data_b )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    rep_xy_a = repmat(x, length(data_a), 1);
    rep_xy_b = repmat(x, length(data_b), 1);
    
    function [eu_dist] = get_eu_dist(pt1, pt2)
        eu_dist = sqrt((pt1(:,1)-pt2(:,1)).^2 + (pt1(:,1)-pt2(:,1)).^2);
    end

    eu_x_a = get_eu_dist(rep_xy_a, data_a);
    eu_x_b = get_eu_dist(rep_xy_b, data_b);
    
    min_a = min(eu_x_a);
    min_b = min(eu_x_b);
    
    if (min_a<min_b)
        class = 0;
    else
        class = 1;
    end
end

