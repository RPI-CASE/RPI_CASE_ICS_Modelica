load('ICSolar.ICS_Skeleton_res.mat');

%obesr
eGen_O = data_2(1149,94:123);
%Modeled
eGen_M = data_2(1171,94:123);

%Triming the Bad Data Point
%eGen_O(5) = [];
%eGen_M(5) = [];

%Calcuate the RSME
Result = sqrt(mean((eGen_O-eGen_M).^2))
