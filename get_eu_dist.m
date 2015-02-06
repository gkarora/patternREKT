function [eu_dist] = get_eu_dist(pt1, pt2)
    eu_dist = sqrt((pt1(:,1)-pt2(:,1)).^2 + (pt1(:,2)-pt2(:,2)).^2);
end

