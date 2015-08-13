function [error, err_percent, r2 ] = RMSE( x, y )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

% X obxerved
% Y in guess

mean_x = mean(x);

SS_tot = sum((x-mean_x).^2);
SS_res = sum((x-y).^2);

r2 = 1 - SS_res / SS_tot;




error = sqrt(mean((x-y).^2));
err_percent = error / mean(x);



end

