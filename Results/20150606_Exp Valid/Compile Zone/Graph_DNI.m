clc;

clear all;
load('ICSolar.ICS_Skeleton_20_Feb_2015.mat','measured_DNI');
Feb20 = measured_DNI;

load('ICSolar.ICS_Skeleton_19_Mar_2015.mat','measured_DNI');
Mar19 = measured_DNI;

load('ICSolar.ICS_Skeleton_23_Mar_2015.mat','measured_DNI');
Mar23 = measured_DNI;


 hold on;
 plot(Feb20);
 plot(Mar19);
 plot(Mar23);
 
 
 legend('Feb20','Mar19','Mar23',...
    'Location','southeast');    %'southeast'
set(legend,'FontName','Arial Narrow');