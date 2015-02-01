function [class] = ged_3(x, sigmaC, muC, sigmaD, muD, sigmaE, muE )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

    function [dist] = get_dis(test_pt, mu, sigma)
       dist = (test_pt - mu)*(sigma^-1)*(test_pt - mu)'; 
    end
    
    if(get_dis(x, muC, sigmaC)> get_dis(x, muD, sigmaD))
        if (get_dis(x, muD, sigmaD)> get_dis(x, muE, sigmaE))
            class = 3;
        else
            class = 2;
        end
    else
        if (get_dis(x, muC, sigmaC)> get_dis(x, muE, sigmaE))
            class = 3;
        else
            class = 1;
        end
    end
end

