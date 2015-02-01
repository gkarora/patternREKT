function [class] = ged_2( sigmaA, muA, sigmaB, muB )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

    function [dist] = get_dist(test_pt, mu, sigma)
       dist = ((test_pt - mu)')*(sigma^-1)*(test_pt - mu); 
    end
    
    if(get_dist(x, muA, sigmaA)> get_dist(x, muB, sigmaB))
        class = 'B';
    else
        class = 'A';
    end
end

