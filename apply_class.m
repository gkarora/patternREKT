function  points_in_class = apply_class(mu, sigma, N, points)
% apply_class(mu, sigma, N)
% This function takes the mean and covariance matrix of a class creates N
% samples which would fall in this class.

% The randn function renders N samples which have the unit circle as the 
% equiprobabilty contour. A transform is applied to the samples in order to
% move them to the class described by the inputs.

R = chol(sigma);
points_in_class = repmat(mu,N,1) + points*R;

end

