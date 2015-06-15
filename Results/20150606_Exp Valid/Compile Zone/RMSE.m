function [error, err_percent] = RMSE( x, y )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

error = sqrt(mean((x-y).^2));
err_percent = error / mean(x);
end

