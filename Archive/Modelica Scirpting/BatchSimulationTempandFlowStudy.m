% What to run
%win_om_path = 'C:\OpenModelica1.9.1\bin\'
%system([win_om_path,'omc.exe +d=failtrace +s simulate-ICSolar.mos.'])
%omimport(modelname, saveName)

cd 'C:\Users\Justin\Documents\GitHub\RPI_CASE_ICS_Modelica\Archive\Modelica Scirpting'

%ROOF
% inletTemp = 358.15
% OneBranchFlow = 1.63533e-006
% display('inletTemp = 358.15, OneBranchFlow = 1.63533e-006')
% win_om_path = 'C:\OpenModelica1.9.1\bin\';
% system([win_om_path,'omc.exe +d=failtrace +s ICSolar_TandFlow_85Cand1.6.mos.']);
% omimport('ICSolar.ICS_Skeleton');
% save('T85C_F1.6.mat');

% clear all

%ROOF
% display('inletTemp = 358.15, OneBranchFlow = 3.0e-006')
% win_om_path = 'C:\OpenModelica1.9.1\bin\';
% system([win_om_path,'omc.exe +d=failtrace +s ICSolar_TandFlow_85Cand3.mos.']);
% omimport('ICSolar.ICS_Skeleton');
% save('T85C_F3.0.mat');

% clear all

%ROOF
display('inletTemp = 358.15, OneBranchFlow = 5.0e-006')
win_om_path = 'C:\OpenModelica1.9.1\bin\';
system([win_om_path,'omc.exe +d=failtrace +s ICSolar_TandFlow_85Cand5.mos.']);
omimport('ICSolar.ICS_Skeleton');
save('T85C_F5.0.mat');

clear all

% %ROOF
% display('inletTemp = 358.15, OneBranchFlow = 7.0e-006')
% win_om_path = 'C:\OpenModelica1.9.1\bin\';
% system([win_om_path,'omc.exe +d=failtrace +s ICSolar_TandFlow_85Cand7.mos.']);
% omimport('ICSolar.ICS_Skeleton');
% save('T85C_F7.0.mat');

% clear all

display('inletTemp = 348.15, OneBranchFlow = 5.0e-006')
win_om_path = 'C:\OpenModelica1.9.1\bin\';
system([win_om_path,'omc.exe +d=failtrace +s ICSolar_TandFlow_75Cand5.mos.']);
omimport('ICSolar.ICS_Skeleton');
save('T75C_F5.0.mat');

clear all

display('inletTemp = 338.15, OneBranchFlow = 5.0e-006')
win_om_path = 'C:\OpenModelica1.9.1\bin\';
system([win_om_path,'omc.exe +d=failtrace +s ICSolar_TandFlow_65Cand5.mos.']);
omimport('ICSolar.ICS_Skeleton');
save('T65C_F5.0.mat');

clear all

display('inletTemp = 328.15, OneBranchFlow = 5.0e-006')
win_om_path = 'C:\OpenModelica1.9.1\bin\';
system([win_om_path,'omc.exe +d=failtrace +s ICSolar_TandFlow_55Cand5.mos.']);
omimport('ICSolar.ICS_Skeleton');
save('T55C_F5.0.mat');

clear all

display('inletTemp = 318.15, OneBranchFlow = 5.0e-006')
win_om_path = 'C:\OpenModelica1.9.1\bin\';
system([win_om_path,'omc.exe +d=failtrace +s ICSolar_TandFlow_45Cand5.mos.']);
omimport('ICSolar.ICS_Skeleton');
save('T45C_F5.0.mat');

clear all

display('inletTemp = 308.15, OneBranchFlow = 5.0e-006')
win_om_path = 'C:\OpenModelica1.9.1\bin\';
system([win_om_path,'omc.exe +d=failtrace +s ICSolar_TandFlow_35Cand5.mos.']);
omimport('ICSolar.ICS_Skeleton');
save('T35C_F5.0.mat');

clear all

display('inletTemp = 298.15, OneBranchFlow = 5.0e-006')
win_om_path = 'C:\OpenModelica1.9.1\bin\';
system([win_om_path,'omc.exe +d=failtrace +s ICSolar_TandFlow_25Cand5.mos.']);
omimport('ICSolar.ICS_Skeleton');
save('T25C_F5.0.mat');

clear all