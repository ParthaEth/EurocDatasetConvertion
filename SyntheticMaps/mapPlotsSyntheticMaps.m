clc
close all

vertices_ground_truth = zeros(7, 31);
vertices_ground_truth(5, :) = 0:30;

vertices_optvi = load('SYN31/vertices_optvi.txt');

plot(vertices_ground_truth(5, :), sqrt(sum((vertices_ground_truth(5:7, :)...
     - vertices_optvi(5:7, :)).^2)));
axis square;
xlim([-1, 31]);
% ylim([-1, 31]);
% zlim([-1, 31]);
xlabel('X(m)\rightarrow')
ylabel('Y(m)\rightarrow')
hold on

vertices_odometry = load('SYN31/vertices_raw_odometry.txt');
plot(vertices_ground_truth(5, :), sqrt(sum((vertices_ground_truth(5:7, :)...
     - vertices_odometry(5:7, :)).^2)));
  
keyframe_positions = 1:3:31;

vertices_cklam = load('SYN31/vertices_cklam.txt');
plot(vertices_ground_truth(5, keyframe_positions),...
     sqrt(sum((vertices_ground_truth(5:7, keyframe_positions)...
     - vertices_cklam(5:7, :)).^2)));
 
vertices_rcklam = load('SYN31/vertices_rcklam.txt');
plot(vertices_ground_truth(5, keyframe_positions),...
     sqrt(sum((vertices_ground_truth(5:7, keyframe_positions)...
     - vertices_rcklam(5:7, :)).^2)));
 
legend('optvi', 'odometry', 'CKLAM', 'rcklam');