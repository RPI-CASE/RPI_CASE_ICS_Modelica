% What to run
%win_om_path = 'C:\OpenModelica1.9.1\bin\'
%system([win_om_path,'omc.exe +d=failtrace +s simulate-ICSolar.mos.'])
%omimport(modelname, saveName)

%SOUTH
%South, Vertical
display('South, vertical')
win_om_path = 'C:\OpenModelica1.9.1\bin\';
system([win_om_path,'omc.exe +d=failtrace +s simulate-ICSolar_S0.mos.']);
omimport('ICSolar.ICS_Skeleton');
save('NYC_0Orie0Tilt.mat');

clear all


%South, 20 degrees
display('South, 20 degrees')
win_om_path = 'C:\OpenModelica1.9.1\bin\';
system([win_om_path,'omc.exe +d=failtrace +s simulate-ICSolar_S20.mos.']);
omimport('ICSolar.ICS_Skeleton');
save('NYC_0Orie20Tilt.mat');

clear all

%South, 45 degrees
display('South, 45 degrees')
win_om_path = 'C:\OpenModelica1.9.1\bin\';
system([win_om_path,'omc.exe +d=failtrace +s simulate-ICSolar_S45.mos.']);
omimport('ICSolar.ICS_Skeleton');
save('NYC_0Orie45Tilt.mat');

clear all

%Roof tilted 60 degrees (0 being vertical)
display('South, 60 degrees')
win_om_path = 'C:\OpenModelica1.9.1\bin\';
system([win_om_path,'omc.exe +d=failtrace +s simulate-ICSolar_S60.mos.']);
omimport('ICSolar.ICS_Skeleton');
save('NYC_0Orie60Tilt.mat');

clear all

%Roof Horizontal
display('South, Horizontal')
win_om_path = 'C:\OpenModelica1.9.1\bin\';
system([win_om_path,'omc.exe +d=failtrace +s simulate-ICSolar_S90.mos.']);
omimport('ICSolar.ICS_Skeleton');
save('NYC_0Orie90Tilt.mat');

clear all


%WEST West, Vertical
display('West, vertical')
win_om_path = 'C:\OpenModelica1.9.1\bin\';
system([win_om_path,'omc.exe +d=failtrace +s simulate-ICSolar_W0.mos.']);
omimport('ICSolar.ICS_Skeleton');
save('NYC_90Orie0Tilt.mat');

clear all

%West, 20 degree tilt
display('West, 20 degrees')
win_om_path = 'C:\OpenModelica1.9.1\bin\';
system([win_om_path,'omc.exe +d=failtrace +s simulate-ICSolar_W20.mos.']);
omimport('ICSolar.ICS_Skeleton');
save('NYC_90Orie20Tilt.mat');

clear all

%West, 45 degree tilt
display('West, 45 degrees')
win_om_path = 'C:\OpenModelica1.9.1\bin\';
system([win_om_path,'omc.exe +d=failtrace +s simulate-ICSolar_W45.mos.']);
omimport('ICSolar.ICS_Skeleton');
save('NYC_90Orie45Tilt.mat');

clear all

%EAST East, Vertical
display('East, vertical')
win_om_path = 'C:\OpenModelica1.9.1\bin\';
system([win_om_path,'omc.exe +d=failtrace +s simulate-ICSolar_E0.mos.']);
omimport('ICSolar.ICS_Skeleton');
save('NYC_-90Orie0Tilt.mat');

clear all

%East, 20 degree tilt
display('East, 20 degrees')
win_om_path = 'C:\OpenModelica1.9.1\bin\';
system([win_om_path,'omc.exe +d=failtrace +s simulate-ICSolar_E20.mos.']);
omimport('ICSolar.ICS_Skeleton');
save('NYC_-90Orie20Tilt.mat');

clear all

%East, 45 degree tilt
display('East, 45 degrees')
win_om_path = 'C:\OpenModelica1.9.1\bin\';
system([win_om_path,'omc.exe +d=failtrace +s simulate-ICSolar_E45.mos.']);
omimport('ICSolar.ICS_Skeleton');
save('NYC_-90Orie45Tilt.mat');

clear all

%SOUTHWEST Southwest, Vertical
display('Southwest, vertical')
win_om_path = 'C:\OpenModelica1.9.1\bin\';
system([win_om_path,'omc.exe +d=failtrace +s simulate-ICSolar_SW0.mos.']);
omimport('ICSolar.ICS_Skeleton');
save('NYC_450Orie0Tilt.mat');

clear all

%Southwest, 20 degree tilt
display('Southwest, 20 degrees')
win_om_path = 'C:\OpenModelica1.9.1\bin\';
system([win_om_path,'omc.exe +d=failtrace +s simulate-ICSolar_SW20.mos.']);
omimport('ICSolar.ICS_Skeleton');
save('NYC_45Orie20Tilt.mat');

clear all

%Southwest, 45 degree tilt
display('Southwest, 45 degrees')
win_om_path = 'C:\OpenModelica1.9.1\bin\';
system([win_om_path,'omc.exe +d=failtrace +s simulate-ICSolar_SW45.mos.']);
omimport('ICSolar.ICS_Skeleton');
save('NYC_45Orie45Tilt.mat');

clear all


%SOUTHEAST Southeast, Vertical
display('Southeast, vertical')
win_om_path = 'C:\OpenModelica1.9.1\bin\';
system([win_om_path,'omc.exe +d=failtrace +s simulate-ICSolar_SE0.mos.']);
omimport('ICSolar.ICS_Skeleton');
save('NYC_-450Orie0Tilt.mat');

clear all

%Southeast, 20 degree tilt
display('Southeast, 20 degrees')
win_om_path = 'C:\OpenModelica1.9.1\bin\';
system([win_om_path,'omc.exe +d=failtrace +s simulate-ICSolar_SE20.mos.']);
omimport('ICSolar.ICS_Skeleton');
save('NYC_-45Orie20Tilt.mat');

clear all

%Southeast, 45 degree tilt
display('Southeast, 45 degrees')
win_om_path = 'C:\OpenModelica1.9.1\bin\';
system([win_om_path,'omc.exe +d=failtrace +s simulate-ICSolar_SE45.mos.']);
omimport('ICSolar.ICS_Skeleton');
save('NYC_-45Orie45Tilt.mat');

clear all

