function [ out ] = Flattern_LUD4d( in )
%FLATTERN_LUD4D Summary of this function goes here
%   Detailed explanation goes here


% Assuming (pitch;yaw;row;column)

%The matrix that keeps on growing
out = zeros(1,5);

%new row to write
n_row = [1,1,1,1,1];


for i = 1:5
    for j = 1:5
        for k = 1:49
            for l = 1:49
               n_row(1)=i;
               n_row(2)=j;
               n_row(3)=72-3*(k-1);
               n_row(4)=-72+3*(l-1);
               n_row(5)=in(k,l,i,j);
               
               out = [out;n_row];
            end
        end
    end
end

%Deletes the top row
out(1,:) = [];


