clc;

clear all;
load('ICSolar.ICS_Skeleton_20_Feb_2015.mat','temp_flowport_a');
Feb20 = temp_flowport_a - 273;

load('ICSolar.ICS_Skeleton_19_Mar_2015.mat','temp_flowport_a');
Mar19 = temp_flowport_a - 273;

load('ICSolar.ICS_Skeleton_23_Mar_2015.mat','temp_flowport_a');
Mar23 = temp_flowport_a - 273;


 hold on;
 plot(Feb20);
 plot(Mar19);
 plot(Mar23);
 
 
 legend('Feb20','Mar19','Mar23',...
    'Location','southeast');    %'southeast'
set(legend,'FontName','Arial Narrow');