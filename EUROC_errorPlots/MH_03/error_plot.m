clc
close all
%load Groundtruth vertex positions
ground_truth_fullmap = fopen('MH_03/true_vertex_id_to_position.csv');
ground_truth_vertices = textscan(ground_truth_fullmap,...
    '%s %f %f %f', 'Delimiter',',');
fclose(ground_truth_fullmap);

% Full map raw odometry vs optvi
optivi_nolc_fullmap = fopen('MH_03/vertices_optvi.csv');
textscan(optivi_nolc_fullmap,'%s', 8, 'Delimiter',',');
optvi_fullmap_vertices = textscan(optivi_nolc_fullmap,...
    '%f %f %f %f %f %f %f %s', 'Delimiter',',');
fclose(optivi_nolc_fullmap);

error_true_optvi_full = zeros(size(optvi_fullmap_vertices{1}, 1), 3);

for i=1:3
    error_true_optvi_full(:, i) = ...
        (optvi_fullmap_vertices{i} - ground_truth_vertices{i + 1}).^2;
end
norm_error_true_optvi_full = sqrt(sum(error_true_optvi_full, 2));
h0 = plot(norm_error_true_optvi_full);
hold on

% raw odometry plot
raw_fullmap = fopen('MH_03/vertices_raw_odometry.csv');
textscan(raw_fullmap,'%s', 8, 'Delimiter',',');
raw_vertices = textscan(raw_fullmap,'%f %f %f %f %f %f %f %s', ...
    'Delimiter',',');
fclose(raw_fullmap);

error_raw_optvi_full = zeros(size(optvi_fullmap_vertices{1}, 1), 3);

for i=1:3
    error_raw_optvi_full(:, i) = ...
        (ground_truth_vertices{i+1} - raw_vertices{i}).^2;
end
norm_err_raw_optvi_full = sqrt(sum(error_raw_optvi_full, 2));

h1 = plot(norm_err_raw_optvi_full);
title('Error plots closure');
xlabel('vertex number \rightarrow');
ylabel('error norm (m) \rightarrow');

% kfh-optvi null marginalization
null_marginalized_map = fopen('MH_03/vertices_kfh_optvi.csv');
textscan(null_marginalized_map,'%s', 8, 'Delimiter',',');
null_marginalized_vertices = textscan(null_marginalized_map,...
    '%f %f %f %f %f %f %f %s', 'Delimiter',',');
fclose(null_marginalized_map);

error_optvi_full_null_marginalized = ...
    zeros(size(null_marginalized_vertices{1}, 1), 3);
keyframe_indices = zeros(size(null_marginalized_vertices{1}, 1), 1);

for i=1:3
    for j=1:size(null_marginalized_vertices{1})
        keyframe_indices(j) = find(not(cellfun('isempty', ...
            strfind(ground_truth_vertices{1}, ...
            null_marginalized_vertices{8}{j}))));
        error_optvi_full_null_marginalized(j, i) = ...
            (null_marginalized_vertices{i}(j) - ...
            ground_truth_vertices{i+1}(keyframe_indices(j)));
    end
end

norm_error_optvi_full_null_marginalized = ...
    sqrt(sum(error_optvi_full_null_marginalized.^2, 2));
h2 = plot(keyframe_indices, norm_error_optvi_full_null_marginalized, 'r');
% plot(keyframe_indices, norm_error_optvi_full_null_marginalized, 'ro');

% kfh-CKLAM marginalization
% CKLAM_marginalized_map = fopen('data/raw_map_cklam_vertices.csv');
CKLAM_marginalized_map = fopen('MH_03/vertices_cklam.csv');
textscan(CKLAM_marginalized_map,'%s', 8, 'Delimiter',',');
CKLAM_marginalized_vertices = textscan(CKLAM_marginalized_map,...
    '%f %f %f %f %f %f %f %s', 'Delimiter',',');
fclose(CKLAM_marginalized_map);

error_optvi_full_CKLAM_marginalized = ...
    zeros(size(CKLAM_marginalized_vertices{1}, 1), 3);
keyframe_indices = zeros(size(CKLAM_marginalized_vertices{1}, 1), 1);

for i=1:3
    for j=1:size(CKLAM_marginalized_vertices{1})
        keyframe_indices(j) = find(not(cellfun('isempty', ...
            strfind(ground_truth_vertices{1}, ...
            CKLAM_marginalized_vertices{8}{j}))));
        error_optvi_full_CKLAM_marginalized(j, i) = ...
            (CKLAM_marginalized_vertices{i}(j) - ...
            ground_truth_vertices{i+1}(keyframe_indices(j)));
    end
end

norm_error_optvi_full_CKLAM_marginalized = ...
    sqrt(sum(error_optvi_full_CKLAM_marginalized.^2, 2));
h3 = plot(keyframe_indices, norm_error_optvi_full_CKLAM_marginalized, 'g');
% plot(keyframe_indices, norm_error_optvi_full_CKLAM_marginalized, 'go');

% kfh-RCKLAM marginalization
RCKLAM_marginalized_map = fopen('MH_03/vertices_rcklam.csv');
textscan(RCKLAM_marginalized_map,'%s', 8, 'Delimiter',',');
RCKLAM_marginalized_vertices = textscan(RCKLAM_marginalized_map,...
    '%f %f %f %f %f %f %f %s', 'Delimiter',',');
fclose(RCKLAM_marginalized_map);

error_optvi_full_RCKLAM_marginalized = ...
    zeros(size(RCKLAM_marginalized_vertices{1}, 1), 3);
keyframe_indices = zeros(size(RCKLAM_marginalized_vertices{1}, 1), 1);

for i=1:3
    for j=1:size(RCKLAM_marginalized_vertices{1})
        keyframe_indices(j) = find(not(cellfun('isempty', ...
            strfind(ground_truth_vertices{1}, ...
            RCKLAM_marginalized_vertices{8}{j}))));
        error_optvi_full_RCKLAM_marginalized(j, i) = ...
            (RCKLAM_marginalized_vertices{i}(j) - ...
            ground_truth_vertices{i + 1}(keyframe_indices(j)));
    end
end

norm_error_optvi_full_RCKLAM_marginalized = ...
    sqrt(sum(error_optvi_full_RCKLAM_marginalized.^2, 2));
h4 = plot(keyframe_indices, norm_error_optvi_full_RCKLAM_marginalized, 'k');
% plot(keyframe_indices, norm_error_optvi_full_RCKLAM_marginalized, 'ko');

legend([h0, h2, h1, h3, h4], 'optvi', 'null marginalization', ...
    'Raw odometry', 'CKLAM', 'RCKLAM')