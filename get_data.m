function [data, contour] = get_data(class, mu, sigma, N)
% get_data(mu, sigma, N)
points = randn(N,2);
points_in_class = apply_class(mu, sigma, N, points);

% Need transposed matrix of circle's points
ellipse_pts = ellipse(0,0,0,1,1)';
equi_prob_contour = apply_class(mu, sigma, length(ellipse_pts), ellipse_pts);
figure

subplot(2,1,1);
title(class);

plot_data_epc(points, ellipse_pts, 'b');
title('Random points');
xlabel('x1');
ylabel('x2');
subplot(2,1,2);
plot_data_epc(points_in_class, equi_prob_contour, 'b');
transformed_titled = 'Transformed to class  ';
title(strcat(transformed_titled,class));
xlabel('x1');
ylabel('x2');
hold off

data = points_in_class;
contour = equi_prob_contour;
end
