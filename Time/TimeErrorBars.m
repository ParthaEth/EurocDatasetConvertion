% Time taken by different methods
map_name = 'MH03';

%% full batch
full_batch = load([map_name,'/',map_name,'_full_batch_time']);
full_batch_timings = diff(full_batch(:,end));
full_batch_mean_timing = mean(full_batch_timings)
full_batch_timing_var = sqrt(var(full_batch_timings))

%% NULL
null_m = load([map_name,'/',map_name,'_null_time']);
null_timings = diff(null_m(:,end));
null_mean_timing = mean(null_timings)
null_timing_var = sqrt(var(null_timings))

%% CKLAM
cklam = load([map_name,'/',map_name,'_cklam_time']);
cklam_timings = diff(cklam(:,end));
cklam_mean_timing = mean(cklam_timings)
cklam_timing_var = sqrt(var(cklam_timings))

%% RCKLAM 
rcklam = load([map_name,'/',map_name,'_rcklam_time']);
rcklam_timings = diff(rcklam(:,end));
rcklam_mean_timing = mean(rcklam_timings)
rcklam_timing_var = sqrt(var(rcklam_timings))

%% error bar plots
errorbar(1:4, ...
    [full_batch_mean_timing, null_mean_timing, cklam_mean_timing, rcklam_mean_timing],...
[full_batch_timing_var, null_timing_var, cklam_timing_var, rcklam_timing_var]);