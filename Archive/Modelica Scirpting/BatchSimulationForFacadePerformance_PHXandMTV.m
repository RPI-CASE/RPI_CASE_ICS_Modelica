% What to run
%win_om_path = 'C:\OpenModelica1.9.1\bin\'
%system([win_om_path,'omc.exe +d=failtrace +s simulate-ICSolar.mos.'])
%omimport(modelname, saveName)

cd 'C:\Users\Justin\Documents\GitHub\RPI_CASE_ICS_Modelica\Archive\Modelica Scirpting'

%SOUTH
%South, Vertical
display('South, vertical')
win_om_path = 'C:\OpenModelica1.9.1\bin\';
system([win_om_path,'omc.exe +d=failtrace +s PHX_ICSolar_S0.mos.']);
omimport('ICSolar.ICS_Skeleton');
save('PHX_S0Tilt.mat');


clear all


%South, 20 degrees
display('South, 20 degrees')
win_om_path = 'C:\OpenModelica1.9.1\bin\';
system([win_om_path,'omc.exe +d=failtrace +s PHX_ICSolar_S20.mos.']);
omimport('ICSolar.ICS_Skeleton');
save('PHX_S20Tilt.mat');

clear all


%South, 45 degrees
display('South, 45 degrees')
win_om_path = 'C:\OpenModelica1.9.1\bin\';
system([win_om_path,'omc.exe +d=failtrace +s PHX_ICSolar_S45.mos.']);
omimport('ICSolar.ICS_Skeleton');
save('PHX_S45Tilt.mat');

clear all

%Roof tilted 60 degrees (0 being vertical)
display('South, 60 degrees')
win_om_path = 'C:\OpenModelica1.9.1\bin\';
system([win_om_path,'omc.exe +d=failtrace +s PHX_ICSolar_S60.mos.']);
omimport('ICSolar.ICS_Skeleton');
save('PHX_S60Tilt.mat');

clear all


%WEST West, Vertical
display('West, vertical')
win_om_path = 'C:\OpenModelica1.9.1\bin\';
system([win_om_path,'omc.exe +d=failtrace +s PHX_ICSolar_W0.mos.']);
omimport('ICSolar.ICS_Skeleton');
save('PHX_W0Tilt.mat');

clear all

%West, 20 degree tilt
display('West, 20 degrees')
win_om_path = 'C:\OpenModelica1.9.1\bin\';
system([win_om_path,'omc.exe +d=failtrace +s PHX_ICSolar_W20.mos.']);
omimport('ICSolar.ICS_Skeleton');
save('PHX_W20Tilt.mat');

clear all

%West, 45 degree tilt
display('West, 45 degrees')
win_om_path = 'C:\OpenModelica1.9.1\bin\';
system([win_om_path,'omc.exe +d=failtrace +s PHX_ICSolar_W45.mos.']);
omimport('ICSolar.ICS_Skeleton');
save('PHX_W45Tilt.mat');

clear all

%EAST East, Vertical
display('East, vertical')
win_om_path = 'C:\OpenModelica1.9.1\bin\';
system([win_om_path,'omc.exe +d=failtrace +s PHX_ICSolar_E0.mos.']);
omimport('ICSolar.ICS_Skeleton');
save('PHX_E0Tilt.mat');

clear all

%East, 20 degree tilt
display('East, 20 degrees')
win_om_path = 'C:\OpenModelica1.9.1\bin\';
system([win_om_path,'omc.exe +d=failtrace +s PHX_ICSolar_E20.mos.']);
omimport('ICSolar.ICS_Skeleton');
save('PHX_E20Tilt.mat');

clear all

%East, 45 degree tilt
display('East, 45 degrees')
win_om_path = 'C:\OpenModelica1.9.1\bin\';
system([win_om_path,'omc.exe +d=failtrace +s PHX_ICSolar_E45.mos.']);
omimport('ICSolar.ICS_Skeleton');
save('PHX_E45Tilt.mat');

clear all

%SOUTH
%South, Vertical
display('South, vertical')
win_om_path = 'C:\OpenModelica1.9.1\bin\';
system([win_om_path,'omc.exe +d=failtrace +s MTV_ICSolar_S0.mos.']);
omimport('ICSolar.ICS_Skeleton');
save('MTV_S0Tilt.mat');


clear all


%South, 20 degrees
display('South, 20 degrees')
win_om_path = 'C:\OpenModelica1.9.1\bin\';
system([win_om_path,'omc.exe +d=failtrace +s MTV_ICSolar_S20.mos.']);
omimport('ICSolar.ICS_Skeleton');
save('MTV_S20Tilt.mat');

clear all


%South, 45 degrees
display('South, 45 degrees')
win_om_path = 'C:\OpenModelica1.9.1\bin\';
system([win_om_path,'omc.exe +d=failtrace +s MTV_ICSolar_S45.mos.']);
omimport('ICSolar.ICS_Skeleton');
save('MTV_S45Tilt.mat');

clear all

%Roof tilted 60 degrees (0 being vertical)
display('South, 60 degrees')
win_om_path = 'C:\OpenModelica1.9.1\bin\';
system([win_om_path,'omc.exe +d=failtrace +s MTV_ICSolar_S60.mos.']);
omimport('ICSolar.ICS_Skeleton');
save('MTV_S60Tilt.mat');

clear all


%WEST West, Vertical
display('West, vertical')
win_om_path = 'C:\OpenModelica1.9.1\bin\';
system([win_om_path,'omc.exe +d=failtrace +s MTV_ICSolar_W0.mos.']);
omimport('ICSolar.ICS_Skeleton');
save('MTV_W0Tilt.mat');

clear all

%West, 20 degree tilt
display('West, 20 degrees')
win_om_path = 'C:\OpenModelica1.9.1\bin\';
system([win_om_path,'omc.exe +d=failtrace +s MTV_ICSolar_W20.mos.']);
omimport('ICSolar.ICS_Skeleton');
save('MTV_W20Tilt.mat');

clear all

%West, 45 degree tilt
display('West, 45 degrees')
win_om_path = 'C:\OpenModelica1.9.1\bin\';
system([win_om_path,'omc.exe +d=failtrace +s MTV_ICSolar_W45.mos.']);
omimport('ICSolar.ICS_Skeleton');
save('MTV_W45Tilt.mat');

clear all

%EAST East, Vertical
display('East, vertical')
win_om_path = 'C:\OpenModelica1.9.1\bin\';
system([win_om_path,'omc.exe +d=failtrace +s MTV_ICSolar_E0.mos.']);
omimport('ICSolar.ICS_Skeleton');
save('MTV_E0Tilt.mat');

clear all

%East, 20 degree tilt
display('East, 20 degrees')
win_om_path = 'C:\OpenModelica1.9.1\bin\';
system([win_om_path,'omc.exe +d=failtrace +s MTV_ICSolar_E20.mos.']);
omimport('ICSolar.ICS_Skeleton');
save('MTV_E20Tilt.mat');

clear all

%East, 45 degree tilt
display('East, 45 degrees')
win_om_path = 'C:\OpenModelica1.9.1\bin\';
system([win_om_path,'omc.exe +d=failtrace +s MTV_ICSolar_E45.mos.']);
omimport('ICSolar.ICS_Skeleton');
save('MTV_E45Tilt.mat');

clear all

% %Roof Horizontal
% display('South, Horizontal')
% win_om_path = 'C:\OpenModelica1.9.1\bin\';
% system([win_om_path,'omc.exe +d=failtrace +s simulate-ICSolar_S90.mos.']);
% omimport('ICSolar.ICS_Skeleton');
% save('NYC_S90Tilt.mat');

% clear all

% %SOUTHWEST Southwest, Vertical
% display('Southwest, vertical')
% win_om_path = 'C:\OpenModelica1.9.1\bin\';
% system([win_om_path,'omc.exe +d=failtrace +s simulate-ICSolar_SW0.mos.']);
% omimport('ICSolar.ICS_Skeleton');
% save('NYC_SW0Tilt.mat');

% clear all

% %Southwest, 20 degree tilt
% display('Southwest, 20 degrees')
% win_om_path = 'C:\OpenModelica1.9.1\bin\';
% system([win_om_path,'omc.exe +d=failtrace +s simulate-ICSolar_SW20.mos.']);
% omimport('ICSolar.ICS_Skeleton');
% save('NYC_SW20Tilt.mat');

% clear all

% %Southwest, 45 degree tilt
% display('Southwest, 45 degrees')
% win_om_path = 'C:\OpenModelica1.9.1\bin\';
% system([win_om_path,'omc.exe +d=failtrace +s simulate-ICSolar_SW45.mos.']);
% omimport('ICSolar.ICS_Skeleton');
% save('NYC_SW45Tilt.mat');

% clear all


% %SOUTHEAST Southeast, Vertical
% display('Southeast, vertical')
% win_om_path = 'C:\OpenModelica1.9.1\bin\';
% system([win_om_path,'omc.exe +d=failtrace +s simulate-ICSolar_SE0.mos.']);
% omimport('ICSolar.ICS_Skeleton');
% save('NYC_SE0Tilt.mat');

% clear all

% %Southeast, 20 degree tilt
% display('Southeast, 20 degrees')
% win_om_path = 'C:\OpenModelica1.9.1\bin\';
% system([win_om_path,'omc.exe +d=failtrace +s simulate-ICSolar_SE20.mos.']);
% omimport('ICSolar.ICS_Skeleton');
% save('NYC_SE20Tilt.mat');

% clear all

% %Southeast, 45 degree tilt
% display('Southeast, 45 degrees')
% win_om_path = 'C:\OpenModelica1.9.1\bin\';
% system([win_om_path,'omc.exe +d=failtrace +s simulate-ICSolar_SE45.mos.']);
% omimport('ICSolar.ICS_Skeleton');
% save('NYC_SE45Tilt.mat');

% clear all
