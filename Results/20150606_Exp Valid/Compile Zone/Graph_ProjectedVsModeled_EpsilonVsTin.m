clear all;

Blueish = [0 0.45 0.74];
Yellowish = [0.75 0.75 0];
Redish = [0.85 0.33 0.1];
Grey = [.5 .5 .5];

T_ref = 20;

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
    'Start','End','day','measured_T_HTFin',...
    'measured_T_cavAvg','G_DN_6mods','eta_Cgen_6mods',...
    'measured_eta_Cgen_arrayTotal','measured_Ex_epsilon','measured_Egen_arrayTotal',...
    'measured_Qgen_arrayTotal','measured_vFlow','measured_T_HTFout',...
    'GN_arrayTotal','measured_T_s3m5in','measured_T_s3m3in', 'measured_T_s3m1in')



%Plot 20-Feb
% load('ICSolar.ICS_Skeleton_20_Feb_2015.mat','chi_arrayTotal',...
%     'Ex_epsilon_Cgen_6mods','Start','End','day','measured_T_HTFin',...
%     'measured_T_cavAvg','GN_arrayTotal');

Color = Blueish;

%trimmed obseverd 
t_o_vFlow = measured_vFlow(:,Start:End); 
t_s_Tref = (T_ref+273).*ones(1,length(t_o_vFlow));

t_o_Tin =  measured_T_HTFin(:,Start:End) - 273;
t_o_Ts3m5in = measured_T_s3m5in(:,Start:End) - 273;
t_o_Ts3m3in = measured_T_s3m3in(:,Start:End) - 273;
t_o_Ts3m1in = measured_T_s3m1in(:,Start:End) - 273;

t_o_Gdn_mod = G_DN_6mods(:,Start:End)./6;
t_o_Egen_mod = measured_Egen_arrayTotal(:,Start:End)./6;
t_o_Gdn_mod23 = G_DN_6mods(:,Start:End)./3;
t_o_Egen_mod23 = measured_Egen_arrayTotal(:,Start:End)./3;
 
t_o_Qgen6 = 4190 * 974.9 * t_o_vFlow .* (t_o_Ts3m5in - t_o_Tin);
t_o_Qgen23 = 4190 * 974.9 * t_o_vFlow .* (t_o_Ts3m1in - t_o_Ts3m3in);

t_o_Qgen = t_o_Qgen23 + t_o_Qgen6;
t_o_Egen = t_o_Egen_mod + t_o_Egen_mod23; 

[s_Qgen_mod6] = UQ_Qgen(t_o_vFlow,t_o_Tin,t_o_Ts3m5in);
[s_Qgen_mod23] = UQ_Qgen(t_o_vFlow,t_o_Ts3m3in,t_o_Ts3m1in);
s_Qgen = sqrt( (s_Qgen_mod6).^2 + (s_Qgen_mod23).^2);

[t_o_eta_Cgen6, s_eta_Cgen_mod6] = UQ_eta_Cgen(t_o_Qgen6,s_Qgen_mod6,...
    t_o_Egen_mod,t_o_Gdn_mod);
[t_o_eta_Cgen23, s_eta_Cgen_mod23] = UQ_eta_Cgen(t_o_Qgen23,s_Qgen_mod23,...
    t_o_Egen_mod23,t_o_Gdn_mod23);

s_eta_Cgen = sqrt((2/3)^2.*(s_eta_Cgen_mod23).^2 + (1/3)^2.*(s_eta_Cgen_mod6).^2);
t_o_eta_Cgen = (2/3)*t_o_eta_Cgen23 + (1/3)*t_o_eta_Cgen6;


[s_ex_epsilon_mod6,t_o_epsilon_mod6] = UQ_ex_epsilon(...
    t_o_vFlow,t_s_Tref,t_o_Tin,t_o_Ts3m5in,t_o_Egen_mod,t_o_Gdn_mod,0.5);
[s_ex_epsilon_mod23,t_o_epsilon_mod23] = UQ_ex_epsilon(...
    t_o_vFlow,t_s_Tref,t_o_Ts3m3in,t_o_Ts3m1in,t_o_Egen_mod23,t_o_Gdn_mod23,0.5);


s_ex_epsilon =  sqrt( ((1/3)^2).* s_ex_epsilon_mod6.^2  + ((2/3)^2).* s_ex_epsilon_mod23.^2);

t_o_epsilon = (t_o_epsilon_mod6 + 2.*t_o_epsilon_mod23 )./3;


%add the zero point

scatter(t_o_Tin(1:nthElement:end)',t_o_epsilon(1:nthElement:end)',...
    markerSize,'o',...
    'MarkerFaceColor',Color,...
    'MarkerEdgeColor',Color,...
    'DisplayName','20 Feb \epsilon');


f=fit(t_o_Tin',t_o_eta_Cgen','poly1');
x=0:5:100;
y=f(x);

plot(x,y,'LineStyle',':',...
    'Color',Color,...
    'LineWidth',3);

scatter(t_o_Tin(1:nthElement:end)',t_o_eta_Cgen(1:nthElement:end)',...
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

f=fit(t_o_Tin',t_o_epsilon','poly2');
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
load('PROJECTED_ICSolar.ICS_Skeleton_20_Feb_2015_v7.mat','chi_arrayTotal',...
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
