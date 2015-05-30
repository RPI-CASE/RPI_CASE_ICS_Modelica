function [ X_out ] = poly(X_in)
%FACTORIZATION Summary of this function goes here
%   Detailed explanation goes here

%polynomial output
X_out = X_in;

%the new column of data to write;
X_C = zeros(size(X_in,1),10);

X_C(:,1) = X_in(:,3).^2;
X_C(:,2) = X_in(:,3).* X_in(:,4);
X_C(:,3) = X_in(:,4).^2;
X_C(:,4) = (X_in(:,1).^2).*(X_in(:,2).^2);
X_C(:,5) = X_in(:,1).^2;
X_C(:,6) = X_in(:,2).^2;
X_C(:,7) = X_in(:,1).^4;
X_C(:,8) = X_in(:,2).^4;
X_C(:,9) = X_in(:,3).^4;
X_C(:,10) = X_in(:,4).^4;

X_C(:,11) = X_in(:,1).^3;
X_C(:,12) = X_in(:,2).^3;
X_C(:,13) = X_in(:,1).^3.*X_in(:,2);
X_C(:,14) = X_in(:,1).*X_in(:,2).^3;
X_C(:,15) = X_in(:,3).^2.*X_in(:,4);
X_C(:,16) = X_in(:,3).*X_in(:,4).^2;
X_C(:,17) = X_in(:,3).^3.*X_in(:,4);
X_C(:,18) = X_in(:,3).*X_in(:,4).^3;



X_out = [X_out X_C];










end

