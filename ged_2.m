function [class] = ged_2(x, sigmaA, muA, sigmaB, muB )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

    function [dist] = get_dis(test_pt, mu, sigma)
       dist = (test_pt - mu)*(sigma^-1)*(test_pt - mu)'; 
    end
    
    if(get_dis(x, muA, sigmaA)> get_dis(x, muB, sigmaB))
        class = 2;
    else
        class = 1;
    end
end

