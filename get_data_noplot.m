function [data, contour] = get_data_noplot(mu, sigma, N)
% get_data(mu, sigma, N)
points = randn(N,2);
points_in_class = apply_class(mu, sigma, N, points);

% Need transposed matrix of circle's points
ellipse_pts = ellipse(0,0,0,1,1)';
equi_prob_contour = apply_class(mu, sigma, length(ellipse_pts), ellipse_pts);

data = points_in_class;
contour = equi_prob_contour;
end
