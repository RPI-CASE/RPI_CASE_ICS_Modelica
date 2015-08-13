%% Load parameters from all files to compar
clc;
clear all;

err = [0,0,0];
per_err = [0,0,0];

total_err = 0;
total_per_err = 0;


load('ICSolar.ICS_Skeleton_20_Feb_2015_vt.mat','Egen_arrayTotal',...
    'measured_Egen_arrayTotal','Qgen_arrayTotal','measured_Qgen_arrayTotal',...
    'Start','End')
%observed 
o_Egen = measured_Egen_arrayTotal(Start:End);
o_Qgen = measured_Qgen_arrayTotal(Start:End); 

% simulated
s_Egen = Egen_arrayTotal(Start:End); 
s_Qgen = Qgen_arrayTotal(Start:End); 

[err(1),per_err(1)] = RMSE(o_Qgen, s_Qgen);





load('ICSolar.ICS_Skeleton_19_Mar_2015_vt.mat','Egen_arrayTotal',...
    'measured_Egen_arrayTotal','Qgen_arrayTotal','measured_Qgen_arrayTotal',...
    'Start','End')
%trimmed observed 
temp1 = measured_Egen_arrayTotal(Start:End);
temp2 = measured_Qgen_arrayTotal(Start:End); 

%trimmed simulated
temp3 = Egen_arrayTotal(Start:End); 
temp4 = Qgen_arrayTotal(Start:End); 

[err(2),per_err(2)] = RMSE(temp2, temp4);

%observed 
o_Egen = [o_Egen measured_Egen_arrayTotal(Start:End)];
o_Qgen = [o_Qgen measured_Qgen_arrayTotal(Start:End)]; 

% simulated
s_Egen = [s_Egen Egen_arrayTotal(Start:End)]; 
s_Qgen = [s_Qgen Qgen_arrayTotal(Start:End)]; 









load('ICSolar.ICS_Skeleton_23_Mar_2015_vt.mat','Egen_arrayTotal',...
    'measured_Egen_arrayTotal','Qgen_arrayTotal','measured_Qgen_arrayTotal',...
    'Start','End')
%trimmed observed 
temp1 = measured_Egen_arrayTotal(Start:End);
temp2 = measured_Qgen_arrayTotal(Start:End); 

%trimmed simulated
temp3 = Egen_arrayTotal(Start:End); 
temp4 = Qgen_arrayTotal(Start:End); 

[err(3),per_err(3)] = RMSE(temp2, temp4);


%observed 
o_Egen = [o_Egen measured_Egen_arrayTotal(Start:End)];
o_Qgen = [o_Qgen measured_Qgen_arrayTotal(Start:End)]; 

% simulated
s_Egen = [s_Egen Egen_arrayTotal(Start:End)]; 
s_Qgen = [s_Qgen Qgen_arrayTotal(Start:End)]; 


[total_err,total_per_err] = RMSE(o_Qgen, s_Qgen);
