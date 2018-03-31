% Runs all Scripts. NOTE: this appears to generate the MAT files, and
% leaves it at that. 
%
% Auth: Kenton Phillips 2015
% Changelog:
% 20180330 NEN looking through maybe adding comments for clarity

% housekeeping
clear all
clc
%C:\OpenModelica1.9.1Beta2\bin\
%win_om_path = 'D:\Application\OpenModelica1.9.1\bin\';
win_om_path = 'C:\OpenModelica1.9.1Beta2\bin\';


%Feb 20 data. pull it in and pick out the useful midsection of the data
%(start and end points)
system([win_om_path,'omc.exe +d=failtrace +s 20-Feb-2015_simulate-ICSolar.mos.']) ;
omimport('ICSolar.ICS_Skeleton');

day = '20 Feb 2015';
Start = 62;
End = 613;

filename = 'ICSolar.ICS_Skeleton_20_Feb_2015_v5.mat';
save(filename);


%Mar 19. pull it in and pick out the useful midsection of the data
%(start and end points)
clear all
win_om_path = 'C:\OpenModelica1.9.1Beta2\bin\';
system([win_om_path,'omc.exe +d=failtrace +s 19-Mar-2015_simulate-ICSolar.mos.']) ;
omimport('ICSolar.ICS_Skeleton');

day = '19 Mar 2015';
Start = 98;
End = 418;

filename = 'ICSolar.ICS_Skeleton_19_Mar_2015_v5.mat';
save(filename);


%Mar 23. pull it in and pick out the useful midsection of the data
%(start and end points)
clear all
win_om_path = 'C:\OpenModelica1.9.1Beta2\bin\';
system([win_om_path,'omc.exe +d=failtrace +s 23-Mar-2015_simulate-ICSolar.mos.']) ;
omimport('ICSolar.ICS_Skeleton');

day = '23 Mar 2015';
Start = 161;
End = 456;

filename = 'ICSolar.ICS_Skeleton_23_Mar_2015_v5.mat';
save(filename);
