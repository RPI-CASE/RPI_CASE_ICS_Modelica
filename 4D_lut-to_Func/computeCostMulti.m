function J = computeCostMulti(X, y, theta)
%COMPUTECOSTMULTI Compute cost for linear regression with multiple variables
%   J = COMPUTECOSTMULTI(X, y, theta) computes the cost of using theta as the
%   parameter for linear regression to fit the data points in X and y

% Initialize some useful values
m = length(y); % number of training examples

if size(X,2) == 2	   % Prevent from acceidentally adding column to array
	X = [ones(m, 1) X];
end

J = 1/(2*m) * sum(((X*theta)-y).^2);



% ====================== YOUR CODE HERE ======================





% =========================================================================

end
  