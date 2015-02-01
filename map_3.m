% MAP Classifier for 3 classes
% INPUT:
% datapoint: the point values as a ROW VECTOR
% muC: mean of class C
% SigmaC: covariance of class C
% numC: number of samples from class C
% muD: mean of class D
% SigmaD: covariance of class D
% numD: number of samples from class D
% muE: mean of class E
% SigmaE: covariance of class E
% numE: number of samples from class E
%
% OUTPUT: the number of the class the point might belong to
% 1 -> Class C
% 2 -> Class D
% 3 -> Class E

% Notes re: implementation 
% 1) compare CD
% 2) compare CE
% 3) compare DE
% Inner workings of the "comparisons" are as in map_2.m

function [classNum] = map_3(datapoint,...
                      muC,SigmaC,numC,...
                      muD,SigmaD,numD,...
                      muE,SigmaE,numE)
                  
    function tform = covarTransform(testpoint,mu,Sigma)
        tform = transpose((testpoint' - mu'))...
                * inv(Sigma)...
                * (testpoint' - mu');
    end

    % GT for C, D, E
    comparisons = [0 0 0];
    
    % compare class C, D. if true, do C.
    if covarTransform(datapoint,muD,SigmaD)...
         - covarTransform(datapoint,muC,SigmaC)...
         > 2*log(numD/numC) + log( det(SigmaC)/det(SigmaD) )
    
     comparisons(1) = 1;
    end
    
    % compare class C, E. if true, do C.
    if covarTransform(datapoint,muE,SigmaE)...
         - covarTransform(datapoint,muC,SigmaC)...
         > 2*log(numE/numC) + log( det(SigmaC)/det(SigmaE) )
     
     comparisons(2) = 1;
    end
    
    % compare class D, E. if true, do D.
    if covarTransform(datapoint,muE,SigmaE)...
        - covarTransform(datapoint,muD,SigmaD)...
        > 2*log(numE/numD) + log( det(SigmaD)/det(SigmaE) )
     comparisons(3) = 1;
    end
    
    % compared C-D and C-E, chose C for both
    if comparisons(1)==1 && comparisons(2)==1
        classNum=1;
    % compared C-D, chose D. then compared D-E, chose D.
    elseif comparisons(1)==0 && comparisons(3)==1
        classNum=2;
    % all other cases are logically E.
    else
        classNum=3;
    end        
end

