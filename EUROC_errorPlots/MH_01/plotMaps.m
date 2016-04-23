clc
close all

addpath('../../utility');

% Plot maps for given foldername.
mapname = 'MH_01';

path = ['./' ,mapname];

%load Groundtruth vertex positions
ground_truth_fullmap = fopen([path, '/true_vertex_id_to_position.csv']);
ground_truth_vertices = textscan(ground_truth_fullmap,...
    '%s %f %f %f', 'Delimiter',',');
fclose(ground_truth_fullmap);

%% Raw odometry
figure;
disp('Raw odometry');
h1 = plot3(ground_truth_vertices{2}, ground_truth_vertices{3},...
           ground_truth_vertices{4});
hold on;

%raw odometry
raw_fullmap = fopen([path, '/vertices_raw_odometry.csv']);
textscan(raw_fullmap,'%s', 8, 'Delimiter',',');
raw_vertices = textscan(raw_fullmap,'%f %f %f %f %f %f %f %s', ...
    'Delimiter',',');
fclose(raw_fullmap);
raw_vertices = ...
    alignOverall(ground_truth_vertices, raw_vertices, 40);
h6 = plot3(raw_vertices{1}, raw_vertices{2}, raw_vertices{3});
legend([h1 h6], 'Ground Truth', 'raw odometry')

%% Optvi
figure;
disp('NULL');
h1 = plot3(ground_truth_vertices{2}, ground_truth_vertices{3},...
           ground_truth_vertices{4});
hold on
% kfh-optvi null marginalization
null_marginalized_map = fopen([path, '/vertices_kfh_optvi.csv']);
textscan(null_marginalized_map,'%s', 8, 'Delimiter',',');
null_marginalized_vertices = textscan(null_marginalized_map,...
    '%f %f %f %f %f %f %f %s', 'Delimiter',',');
fclose(null_marginalized_map);
null_marginalized_vertices = ...
    alignOverall(ground_truth_vertices, null_marginalized_vertices, 250);
h4 = plot3(null_marginalized_vertices{1}, null_marginalized_vertices{2},...
           null_marginalized_vertices{3});
  
legend([h1 h4], 'Ground Truth', 'NULL marginalizer')

%% RCKLAM
figure;
disp('RCKLAM');
h1 = plot3(ground_truth_vertices{2}, ground_truth_vertices{3},...
           ground_truth_vertices{4});
hold on;
% kfh-RCKLAM marginalization
RCKLAM_marginalized_map = fopen([path, '/vertices_rcklam.csv']);
textscan(RCKLAM_marginalized_map,'%s', 8, 'Delimiter',',');
RCKLAM_marginalized_vertices = textscan(RCKLAM_marginalized_map,...
    '%f %f %f %f %f %f %f %s', 'Delimiter',',');
fclose(RCKLAM_marginalized_map);
RCKLAM_marginalized_vertices = ...
    alignOverall(ground_truth_vertices, RCKLAM_marginalized_vertices, 120);
h5 = plot3(RCKLAM_marginalized_vertices{1}, RCKLAM_marginalized_vertices{2},...
           RCKLAM_marginalized_vertices{3});
legend([h1 h5], 'Ground Truth', 'RCKLAM')

%% CKLAM
figure;
disp('CKLAM');
h1 = plot3(ground_truth_vertices{2}, ground_truth_vertices{3},...
           ground_truth_vertices{4});
hold on;
% Marginalized map CKLAM 
CKLAM_marginalized_map = fopen([path, '/vertices_cklam.csv']);
textscan(CKLAM_marginalized_map,'%s', 8, 'Delimiter',',');
CKLAM_marginalized_vertices = textscan(CKLAM_marginalized_map,...
    '%f %f %f %f %f %f %f %s', 'Delimiter',',');
fclose(CKLAM_marginalized_map);
CKLAM_marginalized_vertices = ...
    alignOverall(ground_truth_vertices, CKLAM_marginalized_vertices, 30);
h3 = plot3(CKLAM_marginalized_vertices{1}, CKLAM_marginalized_vertices{2}, ...
           CKLAM_marginalized_vertices{3});
legend([h1, h3], 'Ground Truth', 'CKLAM')

%% OPTVI
% Full map optvi
figure
h1 = plot3(ground_truth_vertices{2}, ground_truth_vertices{3},...
           ground_truth_vertices{4});
hold on

disp('optvi');
optivi_nolc_fullmap = fopen([path, '/vertices_optvi.csv']);
textscan(optivi_nolc_fullmap,'%s', 8, 'Delimiter',',');
optvi_fullmap_vertices = textscan(optivi_nolc_fullmap,...
    '%f %f %f %f %f %f %f %s', 'Delimiter',',');
fclose(optivi_nolc_fullmap);
optvi_fullmap_vertices = ...
    alignOverall(ground_truth_vertices, optvi_fullmap_vertices, 900);
h2 = plot3(optvi_fullmap_vertices{1}, optvi_fullmap_vertices{2}, ...
      optvi_fullmap_vertices{3});
legend([h1, h2], 'Ground Truth', 'optvi')
       