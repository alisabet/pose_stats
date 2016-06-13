% script for importing and plotting angle data from xls
level_1 = [];
num_rows = zeros(1,25);
row_ind = zeros(25,2);
sum_rows = 0;

partcipant = {1:5 1:4 1:7 1:5};
block = {1:7 1:7 1:4 1:3 1:4 ... % 25
         1:7 1:7 1:6 1:7 ... % 27
         1:7 1:7 1:7 1:7 1:7 1:7 1:7 ... % 49
         1:7 1:7 1:7 1:7 1:7}; % 35

pt_ctr = 1;
block_ctr = 1;
ind = 1;

for i = [1 2 4 5]
    for j = partcipant{pt_ctr}
        for k = block{block_ctr}
           file_path = ['C:\PoseStats\Data\Group ' num2str(i) '\P' num2str(j) '\Bricklaying\' num2str(k) '.xls'];
           in_mat = xlsread(file_path);
           num_rows(ind) = size(in_mat,1);

           if (i == 1 && j == 1 && k == 1)
             row_ind(1,:) = [1 num_rows(ind)];
           else
             row_ind(ind,:) = [sum_rows+1 sum_rows+num_rows(ind)];  
           end
           sum_rows = sum_rows + num_rows(ind);
           level_1 = [level_1; in_mat];
           ind = ind + 1;
        end
    end 
    pt_ctr = pt_ctr + 1;
    block_ctr = block_ctr + 1;
end

%% segment angle data into motions for 5 blocks
R_Hip = level_1(:, 55:57);
L_Hip = level_1(:, 70:72);
Centroid_Hip = (R_Hip + L_Hip)/2;

C7_T1_local = level_1(:, 16:18) - Centroid_Hip;
R_Hand_local = level_1(:, 34:36)- Centroid_Hip;
L_Hand_local = level_1(:, 49:51) - Centroid_Hip;

% ang_C7_T1_1 = ang_C7_T1_t(1+300:601,:);
% ang_R_Hand_1 = ang_R_Hand_t(1+300:601,:);
% ang_L_Hand_1 = ang_L_Hand_t(1+300:601,:);

%% Benchmark code for testing data extraction
% level_1_t = importdata('C:\PoseStats\Data\level_1.mat');
% 
% ang_C7_T1_t = level_1_t(:, 16:18);
% ang_R_Hand_t = level_1_t(:, 34:36);
% ang_L_Hand_t = level_1_t(:, 49:51);
% 
% plot3(ang_C7_T1_1(:,1), ang_C7_T1_1(:,2), ang_C7_T1_1(:,3), 'rx', ...
%       ang_R_Hand_1(:,1), ang_R_Hand_1(:,2), ang_R_Hand_1(:,3), 'rs', ...
%       ang_L_Hand_1(:,1), ang_L_Hand_1(:,2), ang_L_Hand_1(:,3), 'rd');
  
%%

%level_1 = importdata('C:\PoseStats\Data\level_1_pose.mat');

clr = [repmat('b',25,1); repmat('r',27,1); repmat('g',49,1); repmat('k',35,1)]; % colours for separating group members in plot

for l = 1:ind-1
   start = floor((row_ind(l,2) - row_ind(l,1))/2) + row_ind(l,1); % index for plot3 to plot it at halfway through motion
   until = row_ind(l,2);
   sample = 3;
   plot3(C7_T1_local(start:sample:until,1), C7_T1_local(start:sample:until,2), C7_T1_local(start:sample:until,3), [clr(l) '^'], ...
         R_Hand_local(start:sample:until,1), R_Hand_local(start:sample:until,2), R_Hand_local(start:sample:until,3), [clr(l) 's'], ...
         L_Hand_local(start:sample:until,1), L_Hand_local(start:sample:until,2), L_Hand_local(start:sample:until,3), [clr(l) 's']);
       hold on; 
end
xlabel('x-axis'); ylabel('y-axis'); zlabel('z-axis'); 
stop = 1;

% timeseries for entire motion
% ang_C7_T1_1 = ang_C7_T1(1:601,:);
% ang_C7_T1_2 = ang_C7_T1(602:1302,:);
% ang_C7_T1_3 = ang_C7_T1(1303:1953,:);
% ang_C7_T1_4 = ang_C7_T1(1954:2524,:);
% ang_C7_T1_5 = ang_C7_T1(2525:3075,:);

% ang_R_Hand_1 = ang_R_Hand(1:601,:);
% ang_R_Hand_2 = ang_R_Hand(602:1302,:);
% ang_R_Hand_3 = ang_R_Hand(1303:1953,:);
% ang_R_Hand_4 = ang_R_Hand(1954:2524,:);
% ang_R_Hand_5 = ang_R_Hand(2525:3075,:);

% ang_L_Hand_1 = ang_L_Hand(1:601,:);
% ang_L_Hand_2 = ang_L_Hand(602:1302,:);
% ang_L_Hand_3 = ang_L_Hand(1303:1953,:);
% ang_L_Hand_4 = ang_L_Hand(1954:2524,:);
% ang_L_Hand_5 = ang_L_Hand(2525:3075,:);


% timeseries with first half of motion cut off
% ang_R_Hand_1 = ang_R_Hand(1+300:601,:);
% ang_R_Hand_2 = ang_R_Hand(602+350:1302,:);
% ang_R_Hand_3 = ang_R_Hand(1303+325:1953,:);
% ang_R_Hand_4 = ang_R_Hand(1954+300:2524,:);
% ang_R_Hand_5 = ang_R_Hand(2525+250:3075,:);
% 
% ang_L_Hand_1 = ang_L_Hand(1+300:601,:);
% ang_L_Hand_2 = ang_L_Hand(602+350:1302,:);
% ang_L_Hand_3 = ang_L_Hand(1303+325:1953,:);
% ang_L_Hand_4 = ang_L_Hand(1954+300:2524,:);
% ang_L_Hand_5 = ang_L_Hand(2525+250:3075,:);
% 
% ang_C7_T1_1 = ang_C7_T1(1+300:601,:);
% ang_C7_T1_2 = ang_C7_T1(602+350:1302,:);
% ang_C7_T1_3 = ang_C7_T1(1303+325:1953,:);
% ang_C7_T1_4 = ang_C7_T1(1954+300:2524,:);
% ang_C7_T1_5 = ang_C7_T1(2525+250:3075,:);
% 
% %%
% 
% plot3(ang_C7_T1_1(:,1), ang_C7_T1_1(:,2), ang_C7_T1_1(:,3), 'bx', ang_R_Hand_1(:,1), ang_R_Hand_1(:,2), ang_R_Hand_1(:,3), 'bs', ang_L_Hand_1(:,1), ang_L_Hand_1(:,2), ang_L_Hand_1(:,3), 'bd', ...
% ang_C7_T1_2(:,1), ang_C7_T1_2(:,2), ang_C7_T1_2(:,3), 'rx', ang_R_Hand_2(:,1), ang_R_Hand_2(:,2), ang_R_Hand_2(:,3), 'rs', ang_L_Hand_2(:,1), ang_L_Hand_2(:,2), ang_L_Hand_2(:,3), 'rd', ...
% ang_C7_T1_3(:,1), ang_C7_T1_3(:,2), ang_C7_T1_3(:,3), 'gx', ang_R_Hand_3(:,1), ang_R_Hand_3(:,2), ang_R_Hand_3(:,3), 'gs', ang_L_Hand_3(:,1), ang_L_Hand_3(:,2), ang_L_Hand_3(:,3), 'gd', ...
% ang_C7_T1_4(:,1), ang_C7_T1_4(:,2), ang_C7_T1_4(:,3), 'mx', ang_R_Hand_4(:,1), ang_R_Hand_4(:,2), ang_R_Hand_4(:,3), 'ms', ang_L_Hand_4(:,1), ang_L_Hand_4(:,2), ang_L_Hand_4(:,3), 'md', ...
% ang_C7_T1_5(:,1), ang_C7_T1_5(:,2), ang_C7_T1_5(:,3), 'kx', ang_R_Hand_5(:,1), ang_R_Hand_5(:,2), ang_R_Hand_5(:,3), 'ks', ang_L_Hand_5(:,1), ang_L_Hand_5(:,2), ang_L_Hand_5(:,3), 'kd');
% legend('Trial 1 - C7_T1', 'Right Hand', 'Left Hand', 'Trial 2', '', '', 'Trial 3', '', '', 'Trial 4', '', '', 'Trial 5', '', '');

% plot3(ang_C7_T1(:,1), ang_C7_T1(:,2), ang_C7_T1(:,3), 'b.', ...
% ang_R_Hand(:,1), ang_R_Hand(:,2), ang_R_Hand(:,3),'rx', ...
% ang_L_Hand(:,1), ang_L_Hand(:,2), ang_L_Hand(:,3),'go');

%scatter3(angles_C7_T1(:,1), angles_C7_T1(:,2), angles_C7_T1(:,3));
%xlabel('joint angle 16'); ylabel('joint angle 17'); zlabel('joint angle 18');
%xlabel('joint angle 34'); ylabel('joint angle 35'); zlabel('joint angle 36');
% scatter3(angles_Left_Hand(:,1), angles_Left_Hand(:,2), angles_Left_Hand(:,3));
% xlabel('joint angle 49'); ylabel('joint angle 50'); zlabel('joint angle 51');