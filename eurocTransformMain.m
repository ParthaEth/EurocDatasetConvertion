function eurocTransformMain()
% read in all groundtruth data
groun_truth_all = csvread('MH01/GroundTruthData.csv',1,0,[1,0,36382,7]);

pose_vector = groun_truth_all(1, 2:8);
T_G_I = getTransformMatrix(pose_vector);

T_I_G = getInverseTransform(T_G_I);

% Get positions of all the vertex poses
transformed_positions = zeros(size(groun_truth_all, 1), 4);
transformed_positions(:, 1) = groun_truth_all(:, 1);

for i=1:size(groun_truth_all)
    T_G_In = getTransformMatrix(groun_truth_all(i, 2:8));
    T_I_In = T_I_G * T_G_In;
    transformed_positions(i, 2:4) = T_I_In(1:3, 4);
end
csvwrite('MH01/GroundTruthPositions.csv',transformed_positions)
end

function T_G_I = getTransformMatrix(pose_vector)
% pose_vector consists of body position in global frame and
% body orientation in global coordinate frame.
q_I_G = pose_vector(4:7);
R_I_G = quat2rotm(q_I_G);

p_I_G = pose_vector(1:3);

T_G_I(1:3, 1:3) = R_I_G';
T_G_I(1:3, 4) = p_I_G;
T_G_I(4, 1:4) = [0, 0, 0, 1];
end

function T_I_G = getInverseTransform(T_G_I)
T_I_G(1:3, 1:3) = T_G_I(1:3, 1:3)';
T_I_G(1:3, 4) = -T_I_G(1:3, 1:3)*T_G_I(1:3, 4);
T_I_G(4, 1:4) = [0, 0, 0, 1];
end