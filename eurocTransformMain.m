function eurocTransformMain()
% read in all groundtruth data
ground_truth_file = fopen('MH_04/GroundTruthData.csv');
textscan(ground_truth_file, '%s', 17, 'Delimiter',',');

groun_truth_all = textscan(ground_truth_file,...
    '%s %n %n %n %n %n %n %n %n %n %n %n %n %n %n %n %n', 'Delimiter',',');

% MH_01
% T_I_G = [0.9543   -0.2982   -0.0236   -4.9731
%          0.2981    0.9545   -0.0074    0.2886
%          0.0247   -0.0000    0.9997   -1.1846
%          0         0         0         1.0000];

% MH_02
% T_I_G = [0.9738   -0.2259   -0.0266   -4.8729
%          0.2261    0.9741    0.0021    0.7186
%          0.0254   -0.0081    0.9996   -1.0441
%          0         0         0         1.0000];

% MH_03
% T_I_G = [0.9511   -0.3086    0.0144   -4.9629
%          0.3085    0.9512    0.0101    0.2525
%         -0.0168   -0.0052    0.9998   -0.5038
%          0         0         0         1.0000];

%MH_04
T_I_G = [-0.5372   -0.8424   -0.0424    1.7161
          0.8421   -0.5328   -0.0832   -4.2021
          0.0475   -0.0804    0.9956   -0.6078
          0         0         0        1.0000];
     
% T_I_G = eye(4);

% Get positions of all the vertex poses and write to file

fid = fopen('MH_04/GroundTruthPositions.csv', 'w');

for i=1:size(groun_truth_all{1}, 1)
    T_G_In = getTransformMatrix([groun_truth_all{2}(i), groun_truth_all{3}(i), groun_truth_all{4}(i),...
        groun_truth_all{5}(i), groun_truth_all{6}(i), groun_truth_all{7}(i), groun_truth_all{7}(i)]);
    T_I_In = T_I_G * T_G_In;
    fprintf(fid, '%s,%.16f,%.16f,%.16f\n', groun_truth_all{1}{i}, T_I_In(1, 4), T_I_In(2, 4), T_I_In(3, 4));
end

fclose(fid);
end

function T_G_I = getTransformMatrix(pose_vector)
% pose_vector consists of body position in global frame and
% body orientation in global coordinate frame.
q_I_G = pose_vector(4:7);
R_I_G = quat2rotm(q_I_G);

p_I_G = pose_vector(1:3);

% the following line should have been 
% T_G_I(1:3, 1:3) = R_I_G'; but since matlab 
% uses passive rotation and we are given active ones
% we need to invert it again.
T_G_I(1:3, 1:3) = R_I_G; 
T_G_I(1:3, 4) = p_I_G;
T_G_I(4, 1:4) = [0, 0, 0, 1];
end

function T_I_G = getInverseTransform(T_G_I)
T_I_G(1:3, 1:3) = T_G_I(1:3, 1:3)';
T_I_G(1:3, 4) = -T_I_G(1:3, 1:3)*T_G_I(1:3, 4);
T_I_G(4, 1:4) = [0, 0, 0, 1];
end