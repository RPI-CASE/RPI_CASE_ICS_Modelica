function [ RMSE ] = RMSE( x1, x2)
%RMSE Summary of this function goes here
%   Detailed explanation goes here

RMSE = sqrt(mean((x1-x2).^2));

end

