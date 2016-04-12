% KFH results in different settings
clc
close all
%load Groundtruth vertex positions
ground_truth_fullmap = fopen('MH_01/true_vertex_id_to_position.csv');
ground_truth_vertices = textscan(ground_truth_fullmap,...
    '%s %f %f %f', 'Delimiter',',');
fclose(ground_truth_fullmap);

% kfh-optvi null marginalization in low key frame setting
null_marginalized_map = fopen('MH_01/vertices_kfh_optvi_low.csv');
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
h1 = plot(keyframe_indices, norm_error_optvi_full_null_marginalized, 'r');
hold on
plot(keyframe_indices, norm_error_optvi_full_null_marginalized, 'ro');

% kfh-optvi null marginalization in medium key frame setting
null_marginalized_map = fopen('MH_01/vertices_kfh_optvi_medium.csv');
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
h2 = plot(keyframe_indices, norm_error_optvi_full_null_marginalized, 'k');
hold on
plot(keyframe_indices, norm_error_optvi_full_null_marginalized, 'ko');

% kfh-optvi null marginalization in high key frame setting
null_marginalized_map = fopen('MH_01/vertices_kfh_optvi.csv');
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
h3 = plot(keyframe_indices, norm_error_optvi_full_null_marginalized, 'g');
hold on
plot(keyframe_indices, norm_error_optvi_full_null_marginalized, 'go');

% full optvi
optivi_nolc_fullmap = fopen('MH_01/vertices_optvi.csv');
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

% kfh-optvi null marginalization in all vertex is key frame setting
null_marginalized_map = fopen('MH_01/vertices_kfh_optvi_all_vertex.csv');
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
indices_to_plot = (mod(keyframe_indices, 20)==0);
h4 = plot(keyframe_indices(indices_to_plot), norm_error_optvi_full_null_marginalized(indices_to_plot), 'mo');

legend([h0, h1, h2, h3, h4], 'full-optvi', 'default ket frame setting(low kf rate)', 'medium kf rate', 'high kf rate', 'every frame is kf')
