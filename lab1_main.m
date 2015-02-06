%% Data
clear all
close all

a_mean = [5 10];
b_mean = [10 15];
c_mean = [5 10];
d_mean = [15 10];
e_mean = [10 5];

a_sigma = [8 0;0 4];
b_sigma = [8 0;0 4];
c_sigma = [8 4;4 40];
d_sigma = [8 0; 0 8];
e_sigma = [10 -5; -5 20];

a_number = 200;
b_number = 200;
c_number = 100;
d_number = 200;
e_number = 150;

%% Part 2: Generating Clusters #1
%  Plotting each class against normally distributed data with mean 0 and 
%  variance 1.

% Class A
[data_a, contour_a] = get_data(a_mean, a_sigma, a_number);

% Class B
[data_b, contour_b] = get_data(b_mean, b_sigma, b_number);

% Class C
[data_c, contour_c] = get_data(c_mean, c_sigma, c_number);

% Class D
[data_d, contour_d] = get_data(d_mean, d_sigma, d_number);

% Class E
[data_e, contour_e] = get_data(e_mean, e_sigma, e_number);

%% Part 2: Generating Clusters #2
%  Plotting Classes A and B together and C, D, and E together.

figure
plot_data_epc(data_a, contour_a, 'b');
plot_data_epc(data_b, contour_b, 'r');
hold off
% 
figure
plot_data_epc(data_c, contour_c, 'b');
plot_data_epc(data_d, contour_d, 'g');
plot_data_epc(data_e, contour_e, 'm');
hold off

%% Part 3 Classification

%PREPARE THE GRIDS
grid_step = 0.05;
%[xValuesAB, yValuesAB, MED_AB] = makeGrid(grid_step, data_a, data_b);
[xValuesAB, yValuesAB, MED_AB] = makeGrid2(grid_step, data_a, data_b);
[xValuesCDE, yValuesCDE, MED_CDE] = makeGrid3(grid_step, data_c, data_d, data_e);

MAP_AB = MED_AB;
MAP_CDE = MED_CDE;
GED_AB = MED_AB;
GED_CDE = MED_CDE;
NN_AB = MED_AB;
NN_CDE = MED_CDE;
KNN_AB = MED_AB;
KNN_CDE = MED_CDE;

AB_means = [a_mean;b_mean]; 
CDE_means = [c_mean;d_mean;e_mean];

% iterate through grid AB
for i = 1:size(MED_AB,1)
    for j = 1:size(MED_AB,2)
        z = [xValuesAB(j) yValuesAB(i)];
        class = med(AB_means,z);   
        MED_AB(i,j)=class;
    end
end
figure(99)
% contourf(xValuesAB, yValuesAB, MED_AB,1);
contour(xValuesAB, yValuesAB, MED_AB,1,'k');
hold on
plot_data_epc(data_a, contour_a, 'b');
plot_data_epc(data_b, contour_b, 'r');
hold off

%iterate through grid CDE
for i = 1:size(MED_CDE,1)
    for j = 1:size(MED_CDE,2)
        z = [xValuesCDE(j) yValuesCDE(i)];
        class = med(CDE_means,z);    
        MED_CDE(i,j)=class;
    end
end

figure(100)
% contourf(xValuesCDE, yValuesCDE, MED_CDE,2);
contour(xValuesCDE, yValuesCDE, MED_CDE,2,'k');
hold on
plot_data_epc(data_c, contour_c, 'b');
plot_data_epc(data_d, contour_d, 'g');
plot_data_epc(data_e, contour_e, 'r');
hold off

% STUPID RETARDED MAP CLASSIFIER

for i = 1:size(MAP_AB,1)
    for j = 1:size(MAP_AB,2)
        z = [xValuesAB(j) yValuesAB(i)];
        class = map_2(z,a_mean,a_sigma,a_number,...
                        b_mean,b_sigma,b_number);
        MAP_AB(i,j)=class;
    end
end
figure(99)
hold on
contour(xValuesAB,yValuesAB,MAP_AB,1,'r');
hold off

for i = 1:size(MAP_CDE,1)
    for j = 1:size(MAP_CDE,2)
         z = [xValuesCDE(j) yValuesCDE(i)];
         class = map_3(z,c_mean,c_sigma,c_number,...
                         d_mean,d_sigma,d_number,...
                         e_mean,e_sigma,e_number);
         MAP_CDE(i,j)=class;
    end
end
figure(100)
hold on
contour(xValuesCDE,yValuesCDE,MAP_CDE,2,'r');
hold off

% PREPARE THE GRIDS
%  A and B
for i = 1:size(GED_AB,1)
    for j = 1:size(GED_AB,2)
        z = [xValuesAB(j) yValuesAB(i)];
        GED_AB(i,j) = ged_2(z, a_sigma, a_mean, b_sigma, b_mean); 
    end
end

figure(99)
hold on
contour(xValuesAB,yValuesAB,GED_AB,1,'c');
hold off

%iterate through grid CDE
for i = 1:size(GED_CDE,1)
    for j = 1:size(GED_CDE,2)
        z = [xValuesCDE(j) yValuesCDE(i)];
        GED_CDE(i,j) = ged_3(z, c_sigma, c_mean, d_sigma, d_mean, e_sigma, e_mean); 
    end
end

figure(100)
hold on
contour(xValuesCDE,yValuesCDE,GED_CDE,2,'c');
hold off

%NN - dis work doe
%iterate through grid AB

% for i = 1:size(NN_AB,1)
%     for j = 1:size(NN_AB,2)
%         z = [xValuesAB(j) yValuesAB(i)];
%         NN_AB(i,j) = nn_2(z,data_a, data_b);
%     end
% end
% 
% figure(110)
% hold on
% plot_data_epc(data_a, contour_a, 'b');
% plot_data_epc(data_b, contour_b, 'r');
% contour(xValuesAB,yValuesAB,NN_AB,2,'c');
% hold off

% %NN_CDE
% for i = 1:size(NN_CDE,1)
%     for j = 1:size(NN_CDE,2)
%         z = [xValuesCDE(j) yValuesCDE(i)];
%         NN_CDE(i,j) = nn_3(z,data_c, data_d, data_e);
%     end
% end
% 
% figure(120)
% hold on
% plot_data_epc(data_c, contour_c, 'b');
% plot_data_epc(data_d, contour_d, 'g');
% plot_data_epc(data_e, contour_e, 'r');
% contour(xValuesCDE,yValuesCDE,NN_CDE,2,'c');
% hold off


% %KNN
% %iterate through grid AB
% 
% for i = 1:size(KNN_AB,1)
%     for j = 1:size(KNN_AB,2)
%         z = [xValuesAB(j) yValuesAB(i)];
%         KNN_AB(i,j) = knn_2(z,data_a, data_b);
%     end
% end
% 
% figure(130)
% hold on
% plot_data_epc(data_a, contour_a, 'b');
% plot_data_epc(data_b, contour_b, 'r');
% contour(xValuesAB,yValuesAB,KNN_AB,2,'c');
% hold off
% 
% %KNN_CDE
% for i = 1:size(KNN_CDE,1)
%     for j = 1:size(KNN_CDE,2)
%         z = [xValuesCDE(j) yValuesCDE(i)];
%         KNN_CDE(i,j) = knn_3(z,data_c, data_d, data_e);
%     end
% end
% 
% figure(140)
% hold on
% plot_data_epc(data_c, contour_c, 'b');
% plot_data_epc(data_d, contour_d, 'g');
% plot_data_epc(data_e, contour_e, 'r');
% contour(xValuesCDE,yValuesCDE,KNN_CDE,2,'c');
% hold off


%Error Calculation
error_MED_AB = 0;

x_min = min(data_a(:,1))
y_min = min(data_a(:,2))

for i = 1:size(data_a,1)
    x = data_a(i,1);
    y = data_a(i,2);
    
    x_index = 0;
    y_index = 0;
 
    if(x_min<0)
        x_index = round((round((x+x_min)/0.05)*0.05)/grid_step) + 1
    else
        x_index = round((round((x-x_min)/0.05)*0.05)/grid_step) + 1
    end
    
    if(y_min<0)
        y_index = round((round((y+y_min)/0.05)*0.05)/grid_step) + 1
    else
        y_index = round((round((y-y_min)/0.05)*0.05)/grid_step) + 1
    end

    class = MED_AB(x_index, y_index)
end






