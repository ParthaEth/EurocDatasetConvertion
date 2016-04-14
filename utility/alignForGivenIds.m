function aligned_other_vertices = alignForGivenIds (ground_truth_vertices, ...
    other_vertices, alignment_frame_ids, visualize)
% finds the best transform so every nth vertex of given two sequence of
% vertices is aligned.
if nargin < 4
    visualize = false;
end

aligned_other_vertices = other_vertices;

params = zeros(1, 3); % Identity trnasform in the begining
average_over_n_vertices = 3;

frames_not_aligned = false;
for i=1:length(alignment_frame_ids)
    start_index = find(not(cellfun('isempty', ...
        strfind(other_vertices{8}, ...
        alignment_frame_ids{i}))));
    if(isempty(start_index))
        frames_not_aligned = true;
    end
end

if(frames_not_aligned)
    num_alignment_frames = length(alignment_frame_ids);
    alignment_frame_ids = cell(num_alignment_frames, 1);
    alignment_frame_indices = round(linspace(1, ...
        length(other_vertices{8}), num_alignment_frames + 1));
    for i=1:num_alignment_frames
        alignment_frame_ids{i} = ...
            other_vertices{8}{alignment_frame_indices(i)};
    end
end

for i=1:length(alignment_frame_ids)
    
    current_alignment_id = alignment_frame_ids{i};
    
    if(i < length(alignment_frame_ids))
        next_alignment_id = alignment_frame_ids{i + 1};
    else
        next_alignment_id = '00000000000000000000000000000000';
    end
    
    start_index = find(not(cellfun('isempty', ...
        strfind(other_vertices{8}, ...
        current_alignment_id))));
    count = 0;
    xdata = [];
    ydata = [];
    for j = start_index:length(other_vertices{8})
        if(strcmp(next_alignment_id, other_vertices{8}{j}))
            break;
        end
        count = count + 1;
        xdata(count, :) = [other_vertices{1}(j), other_vertices{2}(j),...
            other_vertices{3}(j)];
        ground_truth_index = find(not(cellfun('isempty', ...
            strfind(ground_truth_vertices{1}, ...
            other_vertices{8}{j}))));
        
        ydata(count, :) = [ground_truth_vertices{2}(ground_truth_index),...
            ground_truth_vertices{3}(ground_truth_index),...
            ground_truth_vertices{4}(ground_truth_index)];
    end
    
    if(size(xdata, 1) >= average_over_n_vertices)
        initial_residual = ydata-xdata;
        mean_vals = mean(initial_residual);
        varriance = var(initial_residual);
        
        for k=1:3
            bad_index = find(abs(initial_residual(:,k) - mean_vals(k)) > 3*sqrt(varriance(k)));
        end
        
        opt_count = 0;
        xdata_optimization = [];
        ydata_optimization = [];
        for l=1:length(xdata)
            if(isempty(find(bad_index == l)))
                opt_count = opt_count + 1;
                xdata_optimization(opt_count, :) = xdata(l, :);
                ydata_optimization(opt_count, :) = ydata(l, :);
            end
            if(opt_count >= average_over_n_vertices)
                break;
            end
        end
        
        [params_new, ~, ~, exitflag, ~] = ...
            lsqcurvefit(@transform3dPoints, ...
            params, xdata_optimization, ydata_optimization);
        if(exitflag > 0)
            params = params_new;
        end
    end
    aligned_other_vertices_matrix = ...
        transform3dPoints(params, xdata);
    
    aligned_other_vertices{1}(start_index : start_index+count - 1) = ...
        aligned_other_vertices_matrix(:, 1);
    aligned_other_vertices{2}(start_index : start_index+count - 1) = ...
        aligned_other_vertices_matrix(:, 2);
    aligned_other_vertices{3}(start_index : start_index+count - 1) = ...
        aligned_other_vertices_matrix(:, 3);
    
    
end

if(visualize)
    figure;
    plot3(ground_truth_vertices{2}, ground_truth_vertices{3},...
        ground_truth_vertices{4}, 'g');
    hold on
    plot3(aligned_other_vertices{1}, aligned_other_vertices{2},...
        aligned_other_vertices{3});
end

end

function ydata = transform3dPoints(params, xdata)
R_B_G = eye(3);
ydata = (R_B_G * xdata' + repmat(params(1:3)', 1, size(xdata, 1)))';
end