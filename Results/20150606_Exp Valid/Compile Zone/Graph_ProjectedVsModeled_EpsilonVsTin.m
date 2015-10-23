clear all;

Blueish = [0 0.45 0.74];
Yellowish = [0.75 0.75 0];
Redish = [0.85 0.33 0.1];
Grey = [.5 .5 .5];

nthElement = 50;

markerSize = 100;

figure('Color',[1 1 1]);
hold on;

% title({'\chi vs \epsilon','Measured Total Array'},...
%     'FontSize',18,...
%     'FontName','Arial Narrow');

xlabel(strcat('T_{HTF,in}',sprintf('(%cC)',char(176))),...
    'FontName','Arial Narrow',...
     'FontSize',22,...
    'FontWeight','bold');
set(gca,'XGrid','on',...
    'FontName','arial narrow',...
    'FontSize',18,...
    'FontWeight','bold');

ylabel('\epsilon_{Cogen} and \eta_{Cogen}',...ylabel('\epsilon',...
    'FontName','Arial Narrow',...
    'FontSize',26,...
    'FontWeight','bold');
set(gca,'YGrid','on',...
    'FontName','arial narrow',...
    'FontSize',18,...
    'FontWeight','bold');

axis([50 90 0 0.8]);

load('ICSolar.ICS_Skeleton_20_Feb_2015_v5.mat','chi_arrayTotal',...
    'Ex_epsilon_Cgen_6mods','Start','End','day','measured_T_HTFin',...
    'measured_T_cavAvg','G_DN_6mods','eta_Cgen_6mods',...
    'measured_eta_Cgen_arrayTotal','measured_Ex_epsilon');



%Plot 20-Feb
% load('ICSolar.ICS_Skeleton_20_Feb_2015.mat','chi_arrayTotal',...
%     'Ex_epsilon_Cgen_6mods','Start','End','day','measured_T_HTFin',...
%     'measured_T_cavAvg','GN_arrayTotal');

Color = Blueish;

%trimmed obseverd chi and epsilon
t_o_Gdn = G_DN_6mods(:,Start:End);
t_o_epsilon = measured_Ex_epsilon(:,Start:End);
t_o_Tin =  measured_T_HTFin(:,Start:End) - 273;
t_o_Tcav = measured_T_cavAvg(:,Start:End);
delta_T = t_o_Tin - t_o_Tcav;
t_o_eta = measured_eta_Cgen_arrayTotal(:,Start:End);

t_o_chi = delta_T ./ (t_o_Gdn ./ (6 * 0.25019^2)); 


%add the zero point

scatter(t_o_Tin(1:nthElement:end)',t_o_epsilon(1:nthElement:end)',...
    markerSize,'o',...
    'MarkerFaceColor',Color,...
    'MarkerEdgeColor',Color,...
    'DisplayName','20 Feb \epsilon');


f=fit(t_o_Tin',t_o_eta','poly1');
x=0:5:100;
y=f(x);

plot(x,y,'LineStyle',':',...
    'Color',Color,...
    'LineWidth',3);

scatter(t_o_Tin(1:nthElement:end)',t_o_eta(1:nthElement:end)',...
    markerSize,'o',...
    'MarkerFaceColor','w',...
    'MarkerEdgeColor',Color,...
    'DisplayName','20 Feb \eta');

% scatter(t_o_chi',t_o_epsilon_arrayTotal',...
%     'MarkerFaceColor',Color,...
%     'MarkerEdgeColor',Color,...
%     'DisplayName',strcat(...z
%     day,' \chi vs \epsilon'));

% x=0:.01:.2;
% y=f(x);

% plot(x,y,'LineStyle',':',...
%     'DisplayName',strcat(day, ' Linear Bestfit'),...
%     'Color',Color,...
%     'LineWidth',3);



% PREDICTION
Color =Blueish;
% 1.5 ml/s
T_HTFin = [350-273 300-273 325-273 375-273];
predict_eps = [0.1492 0.1414 .152 .1355];

f=fit(T_HTFin',predict_eps','poly2');
x=0:5:100;
y=f(x);
indexmax = find(max(y) == y);
xmax = x(indexmax);
ymax = y(indexmax);

plot(x,y,'LineStyle',':',...
    'DisplayName','Extrapolated Modeled Results',...
    'Color',Color,...
    'LineWidth',3);
% 
% strmax = ['Maximum = ',num2str(xmax)];
% text(xmax,ymax,strmax,'VerticalAlignment','top');


%Plot Projected 20 Feb
load('PROJECTED_ICSolar.ICS_Skeleton_20_Feb_2015_v6.mat','chi_arrayTotal',...
    'Ex_epsilon_Cgen_6mods','Start','End','day','measured_T_HTFin',...
    'measured_T_cavAvg','G_DN_6mods','eta_Cgen_6mods',...
    'eta_Cgen_arrayTotal','Ex_epsilon');

Color = Yellowish;

t_o_Gdn = G_DN_6mods(:,Start:End);
t_o_epsilon = Ex_epsilon(:,Start:End);
t_o_Tin =  measured_T_HTFin(:,Start:End) - 273;
t_o_Tcav = measured_T_cavAvg(:,Start:End);
delta_T = t_o_Tin - t_o_Tcav;
t_o_eta = eta_Cgen_arrayTotal(:,Start:End);

t_o_chi = delta_T ./ (t_o_Gdn ./ (6 * 0.25019^2)); 

% t_o_chi = [t_o_chi 0];
% t_o_epsilon_arrayTotal = [t_o_epsilon_arrayTotal 0.138];

%need to transpose in order to scatter plot
chi_trans = transpose(t_o_chi);
Ex_epsilon_trans = transpose(t_o_epsilon);

scatter(t_o_Tin(1:nthElement:end)',t_o_epsilon(1:nthElement:end)',...
    markerSize,...
    'MarkerFaceColor',Color,...
    'MarkerEdgeColor',Color,...
    'Marker','square',...
    'DisplayName','Projected \epsilon');

f=fit(t_o_Tin',t_o_eta','poly1');
x=0:5:100;
y=f(x);

plot(x,y,'LineStyle',':',...
    'Color',Color,...
    'LineWidth',3);


scatter(t_o_Tin(1:nthElement:end)',t_o_eta(1:nthElement:end)',...
    markerSize,'o',...
    'MarkerFaceColor','w',...
    'MarkerEdgeColor',Color,...
    'Marker','square',...
    'DisplayName','Projected \eta');

T_HTFin = t_o_Tin;
predict_eps = t_o_epsilon;

f=fit(T_HTFin',predict_eps','poly2');
x=0:5:100;
y=f(x);
indexmax = find(max(y) == y);
xmax_2 = x(indexmax);
ymax_2 = y(indexmax);

plot(x,y,'LineStyle',':',...
    'DisplayName','Extrapolated Modeled Results',...
    'Color',Color,...
    'LineWidth',3);


% PREDICTION
Color = Yellowish;
% 1.5 ml/s
predict_chi = [0.006, 0.025, 0.053, 0.08, 0.11];
T_HTFin = [40 50 60 70 80];
predict_eps = [0.3771 0.3833 0.3864 0.3867 0.384];

% f=fit(T_HTFin',predict_eps','poly2');
% x=0:5:100;
% y=f(x);
% 
% plot(x,y,'LineStyle',':',...
%     'DisplayName','Modeled Fit',...
%     'Color',Color,...
%     'LineWidth',3);

% indexmax = find(max(y) == y);
% xmax = x(indexmax);
% ymax = y(indexmax);
% 
% strmax = ['Maximum = ',num2str(xmax)];
% text(xmax,ymax,strmax,'VerticalAlignment','top');
% 

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
set(legend,'FontName','Arial Narrow',...
    'Location','southoutside',...
    'Orientation','horizontal');

filename = 'Projected Chi vs Epsilon - Whole Array for 3 datasets';
savefig(filename);
print(filename,'-dpng');
