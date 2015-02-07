function [ class ] = knn_3( x, data_c, data_d, data_e )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    rep_xy_c = repmat(x, length(data_c), 1);
    rep_xy_d = repmat(x, length(data_d), 1);
    rep_xy_e = repmat(x, length(data_e), 1);

    eu_x_c = get_eu_dist(rep_xy_c, data_c);
    eu_x_d = get_eu_dist(rep_xy_d, data_d);
    eu_x_e = get_eu_dist(rep_xy_e, data_e);

    sorted_c = sort(eu_x_c);
    min_c_5 = sorted_c(1:5);
    min_c = mean2(min_c_5);
    
    sorted_d = sort(eu_x_d);
    min_d_5 = sorted_d(1:5);
    min_d = mean2(min_d_5);
    
    
    sorted_e = sort(eu_x_e);
    min_e_5 = sorted_e(1:5);
    min_e = mean2(min_e_5);
    
    if (min_c<min_d && min_c<min_e)
        class = 0;
    elseif(min_d<min_c && min_d<min_e)
        class = 1;
    elseif (min_e<min_c && min_e< min_d)
        class = 2;
    elseif (min_c<min_d && min_c == min_e)
        class = 2;
    elseif (min_d<min_c && min_d == min_e)
        class = 1;
    elseif (min_d<min_e && min_c == min_d)
        class = 0;
    elseif (min_d == min_e == min_c)
        class = 0;
    end
end

