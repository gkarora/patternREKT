function [data, contour] = get_data(mu, sigma, N)
% get_data(mu, sigma, N)
points = randn(N,2);
points_in_class = apply_class(mu, sigma, N, points);

% Need transposed matrix of circle's points
ellipse = plot_ellipse(0,0,0,1,1)';
equi_prob_contour = apply_class(mu, sigma, length(ellipse), ellipse);

figure
subplot(2,1,1);
plot_data_epc(points, ellipse, 'b');
subplot(2,1,2);
plot_data_epc(points_in_class, equi_prob_contour, 'b');
hold off

data = points_in_class;
contour = equi_prob_contour;
end
