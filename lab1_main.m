%% Data

a_mean = [5 10];
b_mean = [10 15];
c_mean = [5 10];
d_mean = [15 10];
e_mean = [10 5];

%% Part 2: Generating Clusters #1
%  Plotting each class against normally distributed data with mean 0 and 
%  variance 1.

% Class A
[data_a, contour_a] = get_data(a_mean, [8 0;0 4], 200);

% Class B
[data_b, contour_b] = get_data(b_mean, [8 0;0 4], 200);

% Class C
[data_c, contour_c] = get_data(c_mean, [8 4;4 40], 100);

% Class D
[data_d, contour_d] = get_data(d_mean, [8 0;0 8], 200);

% Class E
[data_e, contour_e] = get_data(e_mean, [10 -5;-5 20], 150);
%% Part 2: Generating Clusters #2
%  Plotting Classes A and B together and C, D, and E together.

figure
plot_data_epc(data_a, contour_a, 'b', 'r');
plot_data_epc(data_b, contour_b, 'g', 'm');
hold off

figure
plot_data_epc(data_c, contour_c, 'b', 'r');
plot_data_epc(data_d, contour_d, 'g', 'm');
plot_data_epc(data_e, contour_e, 'c', 'y');
hold off

%% Part 3 Classification

% PREPARE THE GRIDS
[xValuesAB, yValuesAB, MED-AB] = gridPrep(gridSize, A, B);
[xValuesCDE, yValsuesCDE, MED-CDE] = gridPrep(gridSize, C, D, E);


