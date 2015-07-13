%% This plots the measured and project energy generattion from 
%% February 20th
%% Projective data assume higher R_theta and higher optical eta

clc;
clear all;

% ***** INIT
% Color Log
Turquoise = [0.301960796117783 0.745098054409027 0.933333337306976];
Purple = [0.494117647409439 0.184313729405403 0.556862771511078];
Grey = [0.7 0.7 0.7];

% 20-Feb Measured Qgen & Egen 

load('ICSolar.ICS_Skeleton_20_Feb_2015.mat','measured_Qgen_arrayTotal',...
    'measured_Egen_arrayTotal','Start','End','day');

figure('Color',[1 1 1]);
hold on;

axis([0 360 0 200]);

%Create Title
% title({strcat(day,': Array Total Energy Generation'),...
%     '6 Modules of PV & 12 Modules of Thermal Collection',...
%     'Modeled vs Projected'},...
%     'FontName','Arial Narrow',...
%     'FontSize',18);

%Create xlabel
xlabel('Time (minutes)','FontName','Arial Narrow',...
    'FontSize',20,... % 15.4
    'FontWeight','bold');
set(gca,'XTickLabel',{'0','15','30','45','60'},...
    'FontName','arial narrow',...
    'FontSize',18,... % 14
    'FontWeight','bold'); 
set(gca,'XTick',[0 90 190 270 360]);
set(gca,'XGrid','on');

% Create ylabel
ylabel('Power (Watts)','FontName','Arial Narrow',...
    'FontSize',20,...
    'FontWeight','bold');
set(gca,'YGrid','on',...
    'FontName','arial narrow',...
    'FontSize',18,...
    'FontWeight','bold');


%Plot 

t_s_Egen = measured_Egen_arrayTotal(:,Start:End);
t_s_Qgen = measured_Qgen_arrayTotal(:,Start:End); 


plot(t_s_Qgen,'Color',[1 0 0],'DisplayName','t_o_Qgen','LineWidth',2);
plot(t_s_Egen,'Color',Turquoise,...
    'DisplayName','t_o_Egen','LineWidth',2);


%Plot Projected ...
clc;
clear all;

load('PROJECTED_ICSolar.ICS_Skeleton_20_Feb_2015.mat','Qgen_arrayTotal',...
    'Egen_arrayTotal','Start','End','day');
Turquoise = [0.301960796117783 0.745098054409027 0.933333337306976];

t_s_Qgen = Qgen_arrayTotal(:,Start:End);
t_s_Egen = Egen_arrayTotal(:,Start:End);
 


plot(t_s_Qgen,'Color',[1 0 0],...
    'LineWidth',3,...
    'LineStyle',':');
plot(t_s_Egen,'Color',Turquoise,...
    'LineWidth',3,...
    'LineStyle',':');

legend('Modeled Q_{gen}','Modeled E_{gen}',...
   'Projected Q_{gen}','Projected E_{gen}',...
    'Location','eastoutside');    %'southeast'
set(legend,'FontName','Arial Narrow');

filename = strcat(day,'Projected Energy');
savefig(filename);
print(filename,'-dpng');

