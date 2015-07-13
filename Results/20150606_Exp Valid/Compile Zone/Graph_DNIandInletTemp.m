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
 
 
load('ICSolar.ICS_Skeleton_20_Feb_2015.mat','temp_flowport_a');
Feb20_2 = temp_flowport_a - 273;

load('ICSolar.ICS_Skeleton_19_Mar_2015.mat','temp_flowport_a');
Mar19_2 = temp_flowport_a - 273;

load('ICSolar.ICS_Skeleton_23_Mar_2015.mat','temp_flowport_a');
Mar23_2 = temp_flowport_a - 273;


 hold on;
 plot(Feb20_2);
 plot(Mar19_2);
 plot(Mar23_2);
 
 
 
 
 
 
 
 legend('Feb20','Mar19','Mar23',...
    'Location','southeast');    %'southeast'
set(legend,'FontName','Arial Narrow');