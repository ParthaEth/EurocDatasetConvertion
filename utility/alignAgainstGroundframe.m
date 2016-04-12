function aligned_other_vertices = ....
    alignAgainstGroundframe(ground_truth_vertices, ...
    align_every_nt_frame, ...
    other_vertices, visualize)
% finds the best transform so every nth vertex of given two sequence of
% vertices is aligned.
if nargin < 4
    visualize = false;
end
aligned_other_vertices = zeros(size(ground_truth_vertices));

average_over_n_vertices = min(20, align_every_nt_frame);
numframes = length(ground_truth_vertices);

params = zeros(1, 6); % Identity trnasform in the begining
for i = 1:align_every_nt_frame:numframes
    if( i + align_every_nt_frame < numframes)
        xdata = other_vertices(i:i + align_every_nt_frame, :);
        ydata = ground_truth_vertices(i:i + align_every_nt_frame, :);
    else
        xdata = other_vertices(i:numframes, :);
        ydata = ground_truth_vertices(i:numframes, :);
    end
    if(size(xdata, 1) >= average_over_n_vertices)
        params = lsqcurvefit(@transform3dPoints, ...
            params, xdata(1:average_over_n_vertices, :),...
            ydata(1:average_over_n_vertices, :));
    end
    aligned_other_vertices(i: i + size(xdata, 1)-1, :) = ...
        transform3dPoints(params, xdata);
end

if(visualize)
    plot3(ground_truth_vertices(:, 1), ground_truth_vertices(:, 2),...
        ground_truth_vertices(:, 3), 'g');
    hold on
    plot3(aligned_other_vertices(:, 1), aligned_other_vertices(:, 2),...
        aligned_other_vertices(:, 3));
end

end

function ydata = transform3dPoints(params, xdata)
R_B_G = eul2rotm(params(1:3));
ydata = (R_B_G * xdata' + repmat(params(4:6)', 1, size(xdata, 1)))';
end