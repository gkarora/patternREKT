function [dist] = get_micd_dis(test_pt, mu, sigma)
   dist = (test_pt - mu)*(sigma^-1)*(test_pt - mu)'; 
end

