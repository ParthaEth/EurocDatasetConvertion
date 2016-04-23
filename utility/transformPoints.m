function ydata = transformPoints(params, xdata)
R_B_G = eul2rotm(params(1:3));
ydata = (R_B_G * xdata' + repmat(params(4:6)', 1, size(xdata, 1)))';
end