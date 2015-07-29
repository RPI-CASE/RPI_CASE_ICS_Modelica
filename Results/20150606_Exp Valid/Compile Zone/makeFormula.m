function [ formula ] = makeFormula( x_in, coef )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here


 
formula = strcat('y =',{' '}, num2str(coef(1)));


for i = 2:length(x_in)
    formula = strcat(formula,' +',{' '}, num2str(coef(i)),' *',{' '},...
        x_in(i));
end

end

