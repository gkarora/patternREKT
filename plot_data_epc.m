function [] = plot_data_epc( points, epc, c)
% plot_data_epc( points, epc, c_pts, c_epc )
%   To use: set figure before calling and set hold off after calling
scatter(points(:,1), points(:,2), 20, c, 'filled');
hold on
axis equal
plot(epc(:,1), epc(:,2), c);

end

