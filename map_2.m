% MAP Classifier for 2 classes
% INPUT:
% datapoint: the point values as a ROW VECTOR
% muA: mean of class A
% SigmaA: covariance of class A
% numA: number of samples in class A
% muB: mean of class B
% SigmaB: covariance of class B
% numB: number of samples in class B
%
% OUTPUT: the number of the class the point might belong to
% 1 -> Class A
% 2 -> Class B


% Notes re: implementation:
% MAP uses MICD, but there is a term that also incorporaes the variances.
% Also incorporates data from the "prior".
% Think about prior like this: say we have 100 instances of class A, and 
% 300 instances of class B.
% this means that we have 400 instances total.
% If we have 400 instances total, then P(A) is going to be (100/400)
% and then P(B) is going to be (300/400).
% Although we could use these doubles in the log terms of the MAP formula,
% there is no point in doing that since they are sourced from the same
% total number of samples.
% therefore P(B) / P(A) is actually num_b / num_a, where num_b + num_a is 
% 
% 1 is class A, 2 is class B.

function [classNum] = map_2(datapoint,...
                      muA,SigmaA,numA,...
                      muB,SigmaB,numB)
    
    function tform = covarTransform(testpoint,mu,Sigma)
        tform = transpose((testpoint' - mu'))...
                * inv(Sigma)...
                * (testpoint' - mu');
    end

    if covarTransform(datapoint,muB,SigmaB)...
         - covarTransform(datapoint,muA,SigmaA)...
         > 2*log(numB/numA) + log( det(SigmaA)/det(SigmaB) )
     classNum = 1;
    else
     classNum = 2;
    end
end