clear all;

Blueish = [0 0.45 0.74];
Yellowish = [0.75 0.75 0];
Redish = [0.85 0.33 0.1];

figure('Color',[1 1 1]);
hold on;

% title({'\chi vs \epsilon','Measured Total Array'},...
%     'FontSize',18,...
%     'FontName','Arial Narrow');

xlabel(strcat('\chi',sprintf('(%cC m^2 / W)',char(176))),...
    'FontName','Arial Narrow',...
     'FontSize',22,...
    'FontWeight','bold');
set(gca,'XGrid','on',...
    'FontName','arial narrow',...
    'FontSize',18,...
    'FontWeight','bold');

ylabel('\epsilon',...
    'FontName','Arial Narrow',...
    'FontSize',22,...
    'FontWeight','bold');
set(gca,'YGrid','on',...
    'FontName','arial narrow',...
    'FontSize',18,...
    'FontWeight','bold');

axis([0 0.14 0 0.4]);

load('ICSolar.ICS_Skeleton_20_Feb_2015_v2.0.mat','chi_arrayTotal',...
    'Ex_epsilon_Cgen_6mods','Start','End','day','measured_T_HTFin',...
    'measured_T_cavAvg','G_DN_6mods');


%Plot 20-Feb
% load('ICSolar.ICS_Skeleton_20_Feb_2015.mat','chi_arrayTotal',...
%     'Ex_epsilon_Cgen_6mods','Start','End','day','measured_T_HTFin',...
%     'measured_T_cavAvg','GN_arrayTotal');

Color = Blueish;

%trimmed obseverd chi and epsilon
t_o_Gdn = G_DN_6mods(:,Start:End);
t_o_epsilon_arrayTotal = Ex_epsilon_Cgen_6mods(:,Start:End);
t_o_Tin =  measured_T_HTFin(:,Start:End);
t_o_Tcav = measured_T_cavAvg(:,Start:End);
delta_T = t_o_Tin - t_o_Tcav;

t_o_chi = delta_T ./ (t_o_Gdn ./ (6 * 0.25019^2)); 


%add the zero point

scatter(t_o_chi',t_o_epsilon_arrayTotal',...
    'MarkerFaceColor',Color,...
    'MarkerEdgeColor',Color,...
    'DisplayName',strcat(...z
    day,' \chi vs \epsilon'));

% x=0:.01:.2;
% y=f(x);

% plot(x,y,'LineStyle',':',...
%     'DisplayName',strcat(day, ' Linear Bestfit'),...
%     'Color',Color,...
%     'LineWidth',3);


%Plot 19-Mar
load('ICSolar.ICS_Skeleton_19_Mar_2015_v2.0.mat','chi_arrayTotal',...
    'Ex_epsilon_Cgen_6mods','Start','End','day','measured_T_HTFin',...
    'measured_T_cavAvg','G_DN_6mods');

Color = Yellowish;

%Get rid of the tail end of the dat
End = 402;


t_o_Gdn = G_DN_6mods(:,Start:End);
t_o_epsilon_arrayTotal = Ex_epsilon_Cgen_6mods(:,Start:End);
t_o_Tin =  measured_T_HTFin(:,Start:End);
t_o_Tcav = measured_T_cavAvg(:,Start:End);
delta_T = t_o_Tin - t_o_Tcav;

t_o_chi = delta_T ./ (t_o_Gdn ./ (6 * 0.25019^2)); 

% trim the bad data point
t_o_chi(19) = [];
t_o_epsilon_arrayTotal(19) = [];


% t_o_chi = [t_o_chi 0];
% t_o_epsilon_arrayTotal = [t_o_epsilon_arrayTotal 0.138];

%need to transpose in order to scatter plot
chi_trans = transpose(t_o_chi);
Ex_epsilon_trans = transpose(t_o_epsilon_arrayTotal);

f=fit(chi_trans,Ex_epsilon_trans,'poly2');

scatter(chi_trans,Ex_epsilon_trans,...
    'MarkerFaceColor',Color,...
    'MarkerEdgeColor',Color,...
    'DisplayName',strcat(...
    day,' \chi vs \epsilon'));

x=0:.01:.2;
y=f(x);

% plot(x,y,'LineStyle',':',...
%     'DisplayName',strcat(day, ' Linear Bestfit'),...
%     'Color',Color,...
%     'LineWidth',3);

%Plot 23-Mar
load('ICSolar.ICS_Skeleton_23_Mar_2015_v2.0.mat','chi_arrayTotal',...
    'Ex_epsilon_Cgen_6mods','Start','End','day','measured_T_HTFin',...
    'measured_T_cavAvg','G_DN_6mods');

Color = Redish;

%trimmed obseverd chi and epsilon
t_o_Gdn = G_DN_6mods(:,Start:End);
t_o_epsilon_arrayTotal = Ex_epsilon_Cgen_6mods(:,Start:End);
t_o_Tin =  measured_T_HTFin(:,Start:End);
t_o_Tcav = measured_T_cavAvg(:,Start:End);
delta_T = t_o_Tin - t_o_Tcav;

t_o_chi = delta_T ./ (t_o_Gdn ./ (6 * 0.25019^2)); 


%add the zero point

scatter(t_o_chi',t_o_epsilon_arrayTotal',...
    'MarkerFaceColor',Color,...
    'MarkerEdgeColor',Color,...
    'DisplayName',strcat(...z
    day,' \chi vs \epsilon'));

% x=0:.01:.2;
% y=f(x);
% 
% plot(x,y,'LineStyle',':',...
%     'DisplayName',strcat(day, ' Linear Bestfit'),...
%     'Color',Color,...
%     'LineWidth',3);

% PREDICTION
Color = [.5 .5 .5];
% 1.5 ml/s
predict_chi = [0.006, 0.025, 0.053, 0.08, 0.11]  ;
predict_eps = [0.24, 0.2425, 0.242, 0.238, 0.23];

f=fit(predict_chi',predict_eps','poly2');
x=0:.01:.2;
y=f(x);

plot(x,y,'LineStyle',':',...
    'DisplayName','Modeled Fit',...
    'Color',Color,...
    'LineWidth',3);

%3 ml/s
predict_chi = [0, 0.086, 0.17];
predict_eps = [0.1324, 0.1485, 0.123];


f=fit(predict_chi',predict_eps','poly2');
x=0:.01:.2;
y=f(x);

% plot(x,y,'LineStyle','--',...
%     'DisplayName','3 ml/s Fit',...
%     'Color',Color,...
%     'LineWidth',3);

legend('show');
set(legend,'FontName','Arial Narrow');

filename = 'Chi vs Epsilon - Whole Array for 3 datasets';
savefig(filename);
print(filename,'-dpng');
