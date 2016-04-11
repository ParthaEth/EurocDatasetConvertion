function getVertexPosition()
ground_truth_file = fopen('MH_04/GroundTruthPositions.csv');
groun_truth_all = textscan(ground_truth_file,...
    '%u64 %n %n %n', 'Delimiter',',');
fclose(ground_truth_file);

time_offset = groun_truth_all{1, 1}(1);

groun_truth_all{1, 1} = double(groun_truth_all{1, 1} ...
    - time_offset);

id_to_time = fopen('MH_04/vertex_id_to_time.csv');
textscan(id_to_time,'%s', 2, 'Delimiter',',');
vertex_id_to_time_stamp = textscan(id_to_time,...
    '%u64 %s', 'Delimiter',',');
fclose(id_to_time);
vertex_id_to_time_stamp{1} = double(vertex_id_to_time_stamp{1} ...
    - time_offset);

fid = fopen('MH_04/true_vertex_id_to_position.csv', 'w');

for i=1:size(vertex_id_to_time_stamp{1}, 1)
%     id = 
%     index = find(not(cellfun('isempty', ...
%                 strfind(vertex_id_to_time_stamp{2}, id))));
    time_stamp = vertex_id_to_time_stamp{1}(i);

    groundtruth_indices = knnsearch(groun_truth_all{1, 1}, ...
                                    time_stamp,'k',2);
    x2 = [groun_truth_all{2}(groundtruth_indices(2)),...
          groun_truth_all{3}(groundtruth_indices(2)),...
          groun_truth_all{4}(groundtruth_indices(2))];

    x1 = [groun_truth_all{2}(groundtruth_indices(1)),...
          groun_truth_all{3}(groundtruth_indices(1)),...
          groun_truth_all{4}(groundtruth_indices(1))];

    position = ...
        (x2 * (time_stamp -  groun_truth_all{1}(groundtruth_indices(1))) + ...
        x1 * (groun_truth_all{1}(groundtruth_indices(2)) - time_stamp))/...
        double(groun_truth_all{1}(groundtruth_indices(2)) - ...
        groun_truth_all{1}(groundtruth_indices(1)));
    
    fprintf(fid, '%s,%.16f,%.16f,%.16f\n', vertex_id_to_time_stamp{2}{i}, position(1), position(2), position(3));
end
fclose(fid);

end