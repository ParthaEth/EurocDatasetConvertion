% Plot themap

function findingBestTransform()
%load Groundtruth vertex positions
ground_truth_fullmap = fopen('MH_04/true_vertex_id_to_position.csv');
ground_truth_vertices = textscan(ground_truth_fullmap,...
    '%s %f %f %f', 'Delimiter',',');
fclose(ground_truth_fullmap);
plot3(ground_truth_vertices{2}, ground_truth_vertices{3}, ground_truth_vertices{4}, 'g')
hold on

% Full map raw odometry vs optvi
optivi_nolc_fullmap = fopen('MH_04/vertices_optvi.csv');
textscan(optivi_nolc_fullmap,'%s', 8, 'Delimiter',',');
optvi_fullmap_vertices = textscan(optivi_nolc_fullmap,...
    '%f %f %f %f %f %f %f %s', 'Delimiter',',');
fclose(optivi_nolc_fullmap);
plot3(optvi_fullmap_vertices{1}, optvi_fullmap_vertices{2}, optvi_fullmap_vertices{3}, 'r')
title('initial');

params = [0 0 0, 0 0 0];
xdata = [ground_truth_vertices{2}, ground_truth_vertices{3}, ground_truth_vertices{4}];
ydata = [optvi_fullmap_vertices{1}, optvi_fullmap_vertices{2}, optvi_fullmap_vertices{3}];

reestimate = true;

if(reestimate)
    params = lsqcurvefit(@transform3dPoints,params,xdata(1:100, :),ydata(1:100, :));
end

ground_truth_vertives_transformed = transform3dPoints(params, xdata);

plot3(ground_truth_vertives_transformed(:,1), ground_truth_vertives_transformed(:,2), ground_truth_vertives_transformed(:,3), 'k')
 final_transform(1:3, 1:3) = eul2rotm(params(1:3));
 final_transform(1:3, 4) = params(4:6)';
 final_transform(4, 1:4) = [0 0 0 1]
end

function ydata = transform3dPoints(params, xdata)
R_B_G = eul2rotm(params(1:3));
ydata = (R_B_G * xdata' + repmat(params(4:6)', 1, size(xdata, 1)))';
end

