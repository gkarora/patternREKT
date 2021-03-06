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
[data_a, contour_a] = get_data('A', a_mean, a_sigma, a_number);

% Class B
[data_b, contour_b] = get_data('B', b_mean, b_sigma, b_number);

% Class C
[data_c, contour_c] = get_data('C', c_mean, c_sigma, c_number);

% Class D
[data_d, contour_d] = get_data('D', d_mean, d_sigma, d_number);

% Class E
[data_e, contour_e] = get_data('E', e_mean, e_sigma, e_number);

%% Part 2: Generating Clusters #2
%  Plotting Classes A and B together and C, D, and E together.

figure
plot_data_epc(data_a, contour_a, 'b');
plot_data_epc(data_b, contour_b, 'r');
title('Case 1: Class A and B');
xlabel('x1');
ylabel('x2');
legend('Class A', 'Class A Unit STD', 'Class B', 'Class B Unit STD');
hold off
 
figure
plot_data_epc(data_c, contour_c, 'b');
plot_data_epc(data_d, contour_d, 'g');
plot_data_epc(data_e, contour_e, 'm');
title('Case 2: Class C, D, and E');
xlabel('x1');
ylabel('x2');
legend('Class C', 'Class C Unit STD', 'Class D',...
    'Class D Unit STD', 'Class E', 'Class E Unit STD');

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
title('MED : Class A and B');
xlabel('x1');
ylabel('x2');
legend('MED Decision Boundary','Class A', 'Class A Contour', 'Class B', 'Class B Contour');
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
title('MED : Class C, D and E');
xlabel('x1');
ylabel('x2');
legend('MED Decision Boundary','Class C', 'Class C Contour', 'Class D', 'Class D Contour', 'Class E', 'Class E Contour');
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
title('MAP : Class A and B');
xlabel('x1');
ylabel('x2');
legend('MED Decision Boundary','Class A', 'Class A Contour', 'Class B', 'Class B Contour','MAP Decision Boundary');
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
title('MAP : Class C, D and E');
xlabel('x1');
ylabel('x2');
legend('MED Decision Boundary','Class C', 'Class C Contour', 'Class D', 'Class D Contour', 'Class E', 'Class E Contour', 'MAP Decision Boundary');
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
title('GED : Class A and B');
xlabel('x1');
ylabel('x2');
legend('MED Decision Boundary','Class A', 'Class A Contour', 'Class B', 'Class B Contour','MAP Decision Boundary', 'GED Decision Boundary');
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
title('GED : Class C, D and E');
xlabel('x1');
ylabel('x2');
legend('MED Decision Boundary','Class C', 'Class C Contour', 'Class D', 'Class D Contour', 'Class E', 'Class E Contour', 'MAP Decision Boundary', 'GED Decision Boundary');
hold off

%NN - dis work doe
%iterate through grid AB

for i = 1:size(NN_AB,1)
    for j = 1:size(NN_AB,2)
        z = [xValuesAB(j) yValuesAB(i)];
        NN_AB(i,j) = nn_2(z,data_a, data_b);
    end
end

figure(110)
hold on
plot_data_epc(data_a, contour_a, 'b');
plot_data_epc(data_b, contour_b, 'r');
contour(xValuesAB,yValuesAB,NN_AB,1,'c');
title('NN : Class A and B');
xlabel('x1');
ylabel('x2');
legend('Class A', 'Class A Contour', 'Class B', 'Class B Contour','NN Decision Boundary');
hold off

%NN_CDE
for i = 1:size(NN_CDE,1)
    for j = 1:size(NN_CDE,2)
        z = [xValuesCDE(j) yValuesCDE(i)];
        NN_CDE(i,j) = nn_3(z,data_c, data_d, data_e);
    end
end

figure(120)
hold on
plot_data_epc(data_c, contour_c, 'b');
plot_data_epc(data_d, contour_d, 'g');
plot_data_epc(data_e, contour_e, 'r');
contour(xValuesCDE,yValuesCDE,NN_CDE,2,'k');
title('NN : Class C, D and E');
xlabel('x1');
ylabel('x2');
legend('Class C', 'Class C Contour', 'Class D', 'Class D Contour', 'Class E', 'Class E Contour', 'NN Decision Boundary');
hold off


%KNN
%iterate through grid AB

for i = 1:size(KNN_AB,1)
    for j = 1:size(KNN_AB,2)
        z = [xValuesAB(j) yValuesAB(i)];
        KNN_AB(i,j) = knn_2(z,data_a, data_b);
    end
end

figure(110)
hold on
contour(xValuesAB,yValuesAB,KNN_AB,1,'m');
title('5NN : Class A and B');
xlabel('x1');
ylabel('x2');
legend('Class A', 'Class A Contour', 'Class B', 'Class B Contour','MAP Decision Boundary', 'NN Decision Boundary', '5NN Decision Boundary');
hold off

%KNN_CDE
for i = 1:size(KNN_CDE,1)
    for j = 1:size(KNN_CDE,2)
        z = [xValuesCDE(j) yValuesCDE(i)];
        KNN_CDE(i,j) = knn_3(z,data_c, data_d, data_e);
    end
end

figure(120)
hold on
contour(xValuesCDE,yValuesCDE,KNN_CDE,2,'m');
title('5NN : Class C, D and E');
xlabel('x1');
ylabel('x2');
legend('Class C', 'Class C Contour', 'Class D', 'Class D Contour', 'Class E', 'Class E Contour', 'NN Decision Boundary', '5NN Decision Boundary');

hold off




%% Part 4: Error Calculations
% Recall that P(error) is the probability of making an incorrect
% classification.

med_AB_conf = zeros(2,2);
med_CDE_conf = zeros(3,3);
ged_AB_conf = zeros(2,2);
ged_CDE_conf = zeros(3,3);
map_AB_conf = zeros(2,2);
map_CDE_conf = zeros(3,3);
nn_AB_conf = zeros(2,2);
nn_CDE_conf = zeros(3,3);
knn_AB_conf = zeros(2,2);
knn_CDE_conf = zeros(3,3);

% need to generate new data sets for NN and kNN.

% Class A
[data_a_new, ~] = get_data_noplot(a_mean, a_sigma, a_number);
% Class B
[data_b_new, ~] = get_data_noplot(b_mean, b_sigma, b_number);
% Class C
[data_c_new, ~] = get_data_noplot(c_mean, c_sigma, c_number);
% Class D
[data_d_new, ~] = get_data_noplot(d_mean, d_sigma, d_number);
% Class E
[data_e_new, ~] = get_data_noplot(e_mean, e_sigma, e_number);

%MED (1, 2, 3 metric)
for i = 1:size(data_a,1)
    z = [data_a(i,1), data_a(i,2)];
    class = med(AB_means, z);
    if(class==1)
        med_AB_conf(1,1) = med_AB_conf(1,1)+1;
    else
        med_AB_conf(1,2) = med_AB_conf(1,2)+1;
    end
end
for i = 1:size(data_b,1)
    z = [data_b(i,1), data_b(i,2)];
    class = med(AB_means, z);
    if(class==1)
        med_AB_conf(2,1) = med_AB_conf(2,1)+1;
    else
        med_AB_conf(2,2) = med_AB_conf(2,2)+1;
    end
end
for i = 1:size(data_c,1)
    z = [data_c(i,1), data_c(i,2)];
    class = med(CDE_means, z);
    if(class==1)
        med_CDE_conf(1,1) = med_CDE_conf(1,1)+1;
    elseif(class==2)
        med_CDE_conf(1,2) = med_CDE_conf(1,2)+1;
    else
        med_CDE_conf(1,3) = med_CDE_conf(1,3)+1;
    end
end
for i = 1:size(data_d,1)
    z = [data_d(i,1), data_d(i,2)];
    class = med(CDE_means, z);
    if(class==1)
        med_CDE_conf(2,1) = med_CDE_conf(2,1)+1;
    elseif(class==2)
        med_CDE_conf(2,2) = med_CDE_conf(2,2)+1;
    else
        med_CDE_conf(2,3) = med_CDE_conf(2,3)+1;
    end
end
for i = 1:size(data_e,1)
    z = [data_e(i,1), data_e(i,2)];
    class = med(CDE_means, z);
    if(class==1)
        med_CDE_conf(3,1) = med_CDE_conf(3,1)+1;
    elseif(class==2)
        med_CDE_conf(3,2) = med_CDE_conf(3,2)+1;
    else
        med_CDE_conf(3,3) = med_CDE_conf(3,3)+1;
    end
end

%GED
for i = 1:size(data_a,1)
    z = [data_a(i,1), data_a(i,2)];
    class = ged_2(z, a_sigma, a_mean, b_sigma, b_mean); 
    if(class==1)
        ged_AB_conf(1,1) = ged_AB_conf(1,1)+1;
    else
        ged_AB_conf(1,2) = ged_AB_conf(1,2)+1; 
    end
end
for i = 1:size(data_b,1)
    z = [data_b(i,1), data_b(i,2)];
    class = ged_2(z, a_sigma, a_mean, b_sigma, b_mean); 
    if(class==1)
        ged_AB_conf(2,2) = ged_AB_conf(2,2)+1;
    else
        ged_AB_conf(2,1) = ged_AB_conf(2,1)+1; 
    end
end
for i = 1:size(data_c,1)
    z = [data_c(i,1), data_c(i,2)];
    class = ged_2(z, a_sigma, a_mean, b_sigma, b_mean); 
    if(class==1)
        ged_CDE_conf(1,1) = ged_CDE_conf(1,1)+1;
    elseif(class==2)
        ged_CDE_conf(1,2) = ged_CDE_conf(1,2)+1; 
    else
        ged_CDE_conf(1,3) = ged_CDE_conf(1,3)+1;
    end
end
for i = 1:size(data_d,1)
    z = [data_d(i,1), data_d(i,2)];
    class = ged_2(z, a_sigma, a_mean, b_sigma, b_mean); 
    if(class==1)
        ged_CDE_conf(2,1) = ged_CDE_conf(2,1)+1;
    elseif(class==2)
        ged_CDE_conf(2,2) = ged_CDE_conf(2,2)+1; 
    else
        ged_CDE_conf(2,3) = ged_CDE_conf(2,3)+1;
    end
end
for i = 1:size(data_e,1)
    z = [data_e(i,1), data_e(i,2)];
    class = ged_2(z, a_sigma, a_mean, b_sigma, b_mean); 
    if(class==1)
        ged_CDE_conf(3,1) = ged_CDE_conf(3,1)+1;
    elseif(class==2)
        ged_CDE_conf(3,2) = ged_CDE_conf(3,2)+1; 
    else
        ged_CDE_conf(3,3) = ged_CDE_conf(3,3)+1;
    end
end

%MAP
for i = 1:size(data_a,1)
    z = [data_a(i,1), data_a(i,2)];
    class = map_2(z,a_mean,a_sigma,a_number,...
                      b_mean,b_sigma,b_number);
    if(class==1)
        map_AB_conf(1,1) = map_AB_conf(1,1)+1;
    else
        map_AB_conf(1,2) = map_AB_conf(1,2)+1; 
    end
end
for i = 1:size(data_b,1)
    z = [data_b(i,1), data_b(i,2)];
    class = map_2(z,a_mean,a_sigma,a_number,...
                      b_mean,b_sigma,b_number);
    if(class==1)
        map_AB_conf(2,1) = map_AB_conf(2,1)+1;
    else
        map_AB_conf(2,2) = map_AB_conf(2,2)+1; 
    end
end
for i = 1:size(data_c,1)
    z = [data_c(i,1), data_c(i,2)];
    class = map_3(z,c_mean,c_sigma,c_number,...
                    d_mean,d_sigma,d_number,...
                    e_mean,e_sigma,e_number);
    if(class==1)
        map_CDE_conf(1,1) = map_CDE_conf(1,1)+1;
    elseif(class==2)
        map_CDE_conf(1,2) = map_CDE_conf(1,2)+1; 
    else
        map_CDE_conf(1,3) = map_CDE_conf(1,3)+1;
    end
end
for i = 1:size(data_d,1)
    z = [data_d(i,1), data_d(i,2)];
    class = map_3(z,c_mean,c_sigma,c_number,...
                    d_mean,d_sigma,d_number,...
                    e_mean,e_sigma,e_number);
    if(class==1)
        map_CDE_conf(2,1) = map_CDE_conf(2,1)+1;
    elseif(class==2)
        map_CDE_conf(2,2) = map_CDE_conf(2,2)+1; 
    else
        map_CDE_conf(2,3) = map_CDE_conf(2,3)+1;
    end
end
for i = 1:size(data_e,1)
    z = [data_e(i,1), data_e(i,2)];
    class = map_3(z,c_mean,c_sigma,c_number,...
                    d_mean,d_sigma,d_number,...
                    e_mean,e_sigma,e_number);
    if(class==1)
        map_CDE_conf(3,1) = map_CDE_conf(3,1)+1;
    elseif(class==2)
        map_CDE_conf(3,2) = map_CDE_conf(3,2)+1; 
    else
        map_CDE_conf(3,3) = map_CDE_conf(3,3)+1;
    end
end

%NN
for i = 1:size(data_a_new,1)
    z = [data_a_new(i,1), data_a_new(i,2)];
    class = nn_2(z,data_a, data_b);
    if(class==0)
       nn_AB_conf(1,1) = nn_AB_conf(1,1)+1;
    else
       nn_AB_conf(1,2) = nn_AB_conf(1,2)+1;
    end
end
for i = 1:size(data_b_new,1)
    z = [data_b_new(i,1), data_b_new(i,2)];
    class = nn_2(z,data_a, data_b);
    if(class==0)
       nn_AB_conf(2,1) = nn_AB_conf(2,1)+1;
    else
       nn_AB_conf(2,2) = nn_AB_conf(2,2)+1;
    end
end
for i = 1:size(data_c_new,1)
    z = [data_c_new(i,1), data_c_new(i,2)];
    class = nn_3(z,data_c, data_d, data_e);
    if(class==0)
       nn_CDE_conf(1,1) = nn_CDE_conf(1,1)+1;
    elseif(class==1)
       nn_CDE_conf(1,2) = nn_CDE_conf(1,2)+1;
    else
       nn_CDE_conf(1,3) = nn_CDE_conf(1,3)+1;
    end
end
for i = 1:size(data_d_new,1)
    z = [data_d_new(i,1), data_d_new(i,2)];
    class = nn_3(z,data_c, data_d, data_e);
    if(class==0)
       nn_CDE_conf(2,1) = nn_CDE_conf(2,1)+1;
    elseif(class==1)
       nn_CDE_conf(2,2) = nn_CDE_conf(2,2)+1;
    else
       nn_CDE_conf(2,3) = nn_CDE_conf(2,3)+1;
    end
end
for i = 1:size(data_e_new,1)
    z = [data_e_new(i,1), data_e_new(i,2)];
    class = nn_3(z,data_c, data_d, data_e);
    if(class==0)
       nn_CDE_conf(3,1) = nn_CDE_conf(3,1)+1;
    elseif(class==1)
       nn_CDE_conf(3,2) = nn_CDE_conf(3,2)+1;
    else
       nn_CDE_conf(3,3) = nn_CDE_conf(3,3)+1;
    end
end

%kNN
for i = 1:size(data_a_new,1)
    z = [data_a_new(i,1), data_a_new(i,2)];
    class = knn_2(z,data_a, data_b);
    if(class==0)
       knn_AB_conf(1,1) = knn_AB_conf(1,1)+1;
    else
       knn_AB_conf(1,2) = knn_AB_conf(1,2)+1;
    end
end
for i = 1:size(data_b_new,1)
    z = [data_b_new(i,1), data_b_new(i,2)];
    class = knn_2(z,data_a, data_b);
    if(class==0)
       knn_AB_conf(2,1) = knn_AB_conf(2,1)+1;
    else
       knn_AB_conf(2,2) = knn_AB_conf(2,2)+1;
    end
end

for i = 1:size(data_c_new,1)
    z = [data_c_new(i,1), data_c_new(i,2)];
    class = knn_3(z,data_c, data_d, data_e);
    if(class==0)
       knn_CDE_conf(1,1) = knn_CDE_conf(1,1)+1;
    elseif(class==1)
       knn_CDE_conf(1,2) = knn_CDE_conf(1,2)+1;
    else
       knn_CDE_conf(1,3) = knn_CDE_conf(1,3)+1;
    end
end
for i = 1:size(data_d_new,1)
    z = [data_d_new(i,1), data_d_new(i,2)];
    class = knn_3(z,data_c, data_d, data_e);
    if(class==0)
       knn_CDE_conf(2,1) = knn_CDE_conf(2,1)+1;
    elseif(class==1)
       knn_CDE_conf(2,2) = knn_CDE_conf(2,2)+1;
    else
       knn_CDE_conf(2,3) = knn_CDE_conf(2,3)+1;
    end
end
for i = 1:size(data_e_new,1)
    z = [data_e_new(i,1), data_e_new(i,2)];
    class = knn_3(z,data_c, data_d, data_e);
    if(class==0)
       knn_CDE_conf(3,1) = knn_CDE_conf(3,1)+1;
    elseif(class==1)
       knn_CDE_conf(3,2) = knn_CDE_conf(3,2)+1;
    else
       knn_CDE_conf(3,3) = knn_CDE_conf(3,3)+1;
    end
end



med_AB_error = (med_AB_conf(1,2) + med_AB_conf(2,1)) / (a_number+b_number)
med_CDE_error =  conf_matrix_error_sum(med_CDE_conf) / ...
                  (a_number + b_number + c_number)

ged_AB_error = (ged_AB_conf(1,2) + ged_AB_conf(2,1)) / (a_number+b_number)
ged_CDE_error =  conf_matrix_error_sum(ged_CDE_conf) / ...
                  (a_number + b_number + c_number)

map_AB_error = (map_AB_conf(1,2) + map_AB_conf(2,1)) / (a_number+b_number)
map_CDE_error = conf_matrix_error_sum(map_CDE_conf) / ...
                  (a_number + b_number + c_number)
              
nn_AB_error = (nn_AB_conf(1,2) + nn_AB_conf(2,1)) / (a_number+b_number)
nn_CDE_error = conf_matrix_error_sum(nn_CDE_conf) / ...
                  (a_number + b_number + c_number)
             
knn_AB_error = (knn_AB_conf(1,2) + knn_AB_conf(2,1)) / (a_number+b_number)
knn_CDE_error = conf_matrix_error_sum(knn_CDE_conf) / ...
                  (a_number + b_number + c_number)


% The confusion matrix is a table comparing Predicted to Actual values. The
% reason that we want to do error calculation outside of a function is so
% we can leverage the classified data to create this table.
%             Predicted
%           C   D   E
%         C 
% Actual  D    
%         E


% If we tried to run 100 new points from know distributions, IE, generate
% 100 new data points from each C, D, E and then classify them, a perfect
% classifier would generate a confusion matrix of:
% 100   0       0
% 0     100     0
% 0     0       100

% in reality, this is not the case. We might have numbers like:
% 55    22      33
% 11    75      14
% 19    18      63        

% correct classifications lie along the diagonals. Although if we generate
% a point that is right along a decision boundry in THEORY we wouldn't
% classify it, our implementations do. As a consequence, the sum of the
% values in each row should be the total number of data points generated
% from that class that we have attempted to classify.