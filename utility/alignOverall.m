function other_vertices_aligned = ...
    alignOverall(ground_truth_vertices, other_vertices, num_alignment_vertices)

keyframe_indices = zeros(size(other_vertices{1}, 1), 1);
for j=1:size(other_vertices{1}, 1)
    keyframe_indices(j) = find(not(cellfun('isempty', ...
        strfind(ground_truth_vertices{1}, ...
        other_vertices{8}{j}))));
end
xdata = [other_vertices{1}, other_vertices{2}, other_vertices{3}];
ydata = [ground_truth_vertices{2}(keyframe_indices), ...
         ground_truth_vertices{3}(keyframe_indices), ...
         ground_truth_vertices{4}(keyframe_indices)];
params = [0,0,0,0,0,0];
params = lsqcurvefit(@transformPoints, params,...
                     xdata(1:num_alignment_vertices, :),...
                     ydata(1:num_alignment_vertices, :));
        
other_vertices_aligned = other_vertices;
other_vertices_aligned_mat = transformPoints(params, xdata);
other_vertices_aligned{1} = other_vertices_aligned_mat(:, 1);
other_vertices_aligned{2} = other_vertices_aligned_mat(:, 2);
other_vertices_aligned{3} = other_vertices_aligned_mat(:, 3);

deviation_norm = sqrt(sum((ydata - other_vertices_aligned_mat).^2, 2));
mean_deviation = mean(deviation_norm)
var_deviation = var(deviation_norm)
end