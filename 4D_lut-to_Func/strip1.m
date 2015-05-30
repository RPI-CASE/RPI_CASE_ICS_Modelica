function [X Y Z] = strip1(d,value)
%STRIP1 Summary of this function goes here
%   Detailed explanation goes here
length = size(d,1);

for i = 1:length
    if d(i,3) > value
        d(i,:) = [];
    end

end


X = d(:,1);
Y = d(:,2);
Z = d(:,3);

