function [ class ] = nn_3( x, data_c, data_d, data_e )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    rep_xy_c = repmat(x, length(data_c), 1);
    rep_xy_d = repmat(x, length(data_d), 1);
    rep_xy_e = repmat(x, length(data_e), 1);

    
    function [eu_dist] = get_eu_dist(pt1, pt2)
        eu_dist = sqrt((pt1(:,1)-pt2(:,1)).^2 + (pt1(:,1)-pt2(:,1)).^2);
    end

    eu_x_c = get_eu_dist(rep_xy_c, data_c);
    eu_x_d = get_eu_dist(rep_xy_d, data_d);
    eu_x_e = get_eu_dist(rep_xy_e, data_e);

    min_c = min(eu_x_c);
    min_d = min(eu_x_d);
    min_e = min(eu_x_e);
    
    if (min_c<min_d)
        if (min_c<min_e)
            class = 0;
        else
            class = 2;
        end
    else
        if (min_d<min_e)
            class = 1;
        else
            class = 2;
        end
    end
end

