% plot average error
clc
clear all
close all

x = 1:5;

method = {'RO', 'T-KF', 'RCKLAM', 'CKLAM', 'BA'};

%% MH_01

error_norm = [0.3107, 0.2973, 0.2903, 0.2112, 0.2192];
error_std = [0.0412, 0.0179, 0.0067, 0.0232, 0.0080];

for i = 1:5
    errorbar([0, x(i), 6], [0, error_norm(i), 0], [0, error_std(i), 0], 'o', 'MarkerSize',10,'linewidth', 2)
    hold on
end
ax = gca;
ax.XTick = x;
set(ax,'XTickLabel',method)
xlabel('Methods')
ylabel('Error norm \rightarrow')
title('MH\_01')
legend('Raw odometry', 'Traditional Keyframing', 'RCKLAM', 'CKLAM', 'Full Batch Optimization')
% ax.XTickLabelRotation = 45;
set(gca,'FontSize',20);
xlim([0.5, 5.5]);
ylim([0.15, 0.4])
grid on
set(gcf,'PaperPositionMode','auto')
pause
print('-dpng', 'C:\Users\Partha\Documents\git\thesisReport\Presentation\Data\MethodComparisonMH01.png');
%% MH_02
figure
error_norm = [0.2039, 0.1573, 0.1273, 0.1292, 0.1177];
error_std = [0.0121, 0.0078, 0.0061, 0.0068, 0.0043];

for i = 1:5
    errorbar([0, x(i), 6], [0, error_norm(i), 0], [0, error_std(i), 0], 'o', 'MarkerSize',10,'linewidth', 2)
    hold on
end
ax = gca;
ax.XTick = x;
set(ax,'XTickLabel',method)
xlabel('Methods')
ylabel('Error norm \rightarrow')
title('MH\_02')
legend('Raw odometry', 'Traditional Keyframing', 'RCKLAM', 'CKLAM', 'Full Batch Optimization')
% ax.XTickLabelRotation = 45;
set(gca,'FontSize',20);
xlim([0.5, 5.5]);
ylim([0.1, 0.25])
grid on
set(gcf,'PaperPositionMode','auto')
pause
print('-dpng', 'C:\Users\Partha\Documents\git\thesisReport\Presentation\Data\MethodComparisonMH02.png');

%% MH_03
figure
error_norm = [0.2819, 0.2412, 0.2293, 0.2348, 0.1977];
error_std = [0.0334, 0.0323, 0.0329, 0.0126, 0.0127];

for i = 1:5
    errorbar([0, x(i), 6], [0, error_norm(i), 0], [0, error_std(i), 0], 'o', 'MarkerSize',10,'linewidth', 2)
    hold on
end
ax = gca;
ax.XTick = x;
set(ax,'XTickLabel',method)
xlabel('Methods')
ylabel('Error norm \rightarrow')
title('MH\_03')
legend('Raw odometry', 'Traditional Keyframing', 'RCKLAM', 'CKLAM', 'Full Batch Optimization')
% ax.XTickLabelRotation = 45;
set(gca,'FontSize',20);
xlim([0.5, 5.5]);
ylim([0.15, 0.35])
grid on
set(gcf,'PaperPositionMode','auto')
pause
print('-dpng', 'C:\Users\Partha\Documents\git\thesisReport\Presentation\Data\MethodComparisonMH03.png');

%% MH_04
figure
error_norm = [1.8557, 0.6233, 1.9374, 0.3852, 0.5141];
error_std = [1.0452, 0.1266, 1.4039, 0.0287, 0.0509];

for i = 1:5
    errorbar([0, x(i), 6], [0, error_norm(i), 0], [0, error_std(i), 0], 'o', 'MarkerSize',10,'linewidth', 2)
    hold on
end
ax = gca;
ax.XTick = x;
set(ax,'XTickLabel',method)
xlabel('Methods')
ylabel('Error norm \rightarrow')
title('MH\_04')
legend('Raw odometry', 'Traditional Keyframing', 'RCKLAM', 'CKLAM', 'Full Batch Optimization')
% ax.XTickLabelRotation = 45;
set(gca,'FontSize',20);
xlim([0.5, 5.5]);
ylim([0.15, 4])
grid on