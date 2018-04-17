%Graph output of Projected and modeled output for BITCOPT1 paper
%updated and forked NEN 20180404
%   epsilon reporting taken out. 
%   variables 'Start' and 'End' changed to 'dataset_Start' and 'dataset_End'
%authored: Kenton Phillips 2015

% unresolved:
% exporting correct font (Arial Narrow Bold) through EPS
clear all;

progress = "cleared"

%% set some colors
Blueish = [0 0.45 0.74];
Yellowish = [0.75 0.75 0];
Redish = [0.85 0.33 0.1];
Grey = [.5 .5 .5];

Color_Cgen = [75/255,0/255,130/255]; %purple
Color_Egen = [0 0.45 0.74];
Color_Qgen = [0.9 0.0 0.0] ;

T_ref = 20;

nthElement = 50;

progress = "colors set"

%% stub out a figure
MarkerSize = 5;
ScatterMarkerSize = 72;
LineWidthh = 0.8;

% lenovo w510 display is 1920x1080 and 13.5x7.6563
monitorWidth_phys = 13.5; %inches
monitorWidth_px = 1920;
monitorHeight_phys = 7.6563; %inches
monitorHeight_px = 1080;
monitorDPI = mean([monitorHeight_px/monitorHeight_phys monitorWidth_px/monitorWidth_phys]);

figure('Color',[1 1 1]);
axes1 = axes;
hold(axes1,'on');


% hold on;
LineWidthh = 0.8;
FontNamee = 'Arial Narrow Bold';

set(gcf,...
    'Units', 'pixels',...
    'Resize','off'...
    );
set(gca,...
    'Units', 'pixels',...
    'LineWidth',LineWidthh...
    );
%     'Color', 'black',...

MarkerSize = 5;

figPos = 200;
axesWidth_in = 3.5;
axesHeight_in = 3.5;
% set(gcf, 'Position', [3*monitorDPI,3*monitorDPI,axesWidth_in*1.1*monitorDPI,axesHeight_in*1.5*monitorDPI]);
set(gcf, 'Position', [figPos, figPos,axesWidth_in*1.1*monitorDPI,axesHeight_in*1.5*monitorDPI]);
% set(gca, 'Position', [3*monitorDPI,(3+axesHeight_in/2)*monitorDPI,axesWidth_in*monitorDPI,axesHeight_in*monitorDPI]);
set(gca, 'OuterPosition', [0,axesHeight_in/2*monitorDPI,axesWidth_in*monitorDPI,axesHeight_in*monitorDPI]);

% title({'\chi vs \epsilon','Measured Total Array'},...
%     'FontSize',18,...
%     'FontName',FontNamee);

% xlabel('T_{HTF,in}(°C)','FontWeight','bold','FontName',FontNamee);
  xlabel('T_{HTF,in}','FontWeight','bold','FontName',FontNamee);
set(gca,'XGrid','on',...
    'FontName',FontNamee,...
    'FontSize',12); %,...
%     'FontWeight','bold');

%ylabel('\epsilon_{Cogen and eta Cogen',...
ylabel('Efficiency (eta Egen, eta Qgen, eta Cogen)',...
    'FontName',FontNamee,...
    'FontSize',12,...
    'FontWeight','bold');
set(gca,'YGrid','on',...
    'FontName',FontNamee,...
    'FontSize',12,...
    'FontWeight','bold');

% Uncomment the following line to preserve the X-limits of the axes
% xlim(axes1,[50 90]);
% Uncomment the following line to preserve the Y-limits of the axes
% ylim(axes1,[0 0.801]);

axis([50 90 0 0.801]);

set(axes1,'FontName',FontNamee,...
    'FontWeight','bold',...
    'XGrid','on','XTick',[50 55 60 65 70 75 80 85 90],...
    'xcolor','black', 'ycolor','black',...
    'XTickLabel',{'50°C','','60°C','','70°C','','80°C','','90°C'},...
    'YGrid','on','YTick',[0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8]);
%     'OuterPosition',[0 0.2098341856499 1 0.7901658143501],...


progress = 'figure template is setup'

%% SPLICE Plot Feb 20th
%#delperdate
progress = 'plotting Feb20 proto'

load('ICSolar.ICS_Skeleton_20_Feb_2015_v20180330.mat',...
    'chi_arrayTotal',...
    'dataset_Start','dataset_End','day','measured_T_HTFin',...
    'measured_T_cavAvg','G_DN_6mods','eta_Cgen_6mods',...
    'measured_eta_Cgen_arrayTotal','measured_Ex_epsilon','measured_Egen_arrayTotal',...
    'measured_Qgen_arrayTotal','measured_vFlow','measured_T_HTFout',...
    'GN_arrayTotal','measured_T_s3m5in','measured_T_s3m3in', 'measured_T_s3m1in')


dataset_Start = 36 

% t_o_ = trim and groom the observed data into the right length for charting
t_o_vFlow = measured_vFlow(:,dataset_Start:dataset_End); 
%t_s_Tref = (T_ref+273).*ones(1,length(t_o_vFlow));

t_o_Tin =  measured_T_HTFin(:,dataset_Start:dataset_End) - 273;
t_o_Ts3m5in = measured_T_s3m5in(:,dataset_Start:dataset_End) - 273;
t_o_Ts3m3in = measured_T_s3m3in(:,dataset_Start:dataset_End) - 273;
t_o_Ts3m1in = measured_T_s3m1in(:,dataset_Start:dataset_End) - 273;

t_o_Gdn_mod = G_DN_6mods(:,dataset_Start:dataset_End)./6;
t_o_GDN = G_DN_6mods(:,dataset_Start:dataset_End)./6*3;
t_o_Egen_mod = measured_Egen_arrayTotal(:,dataset_Start:dataset_End)./6;
t_o_Gdn_mod23 = G_DN_6mods(:,dataset_Start:dataset_End)./3;
t_o_Egen_mod23 = measured_Egen_arrayTotal(:,dataset_Start:dataset_End)./3;
 
% calc how much Qgen and Egen
t_o_Qgen6 = 4190 * 974.9 * t_o_vFlow .* (t_o_Ts3m5in - t_o_Tin);
t_o_Qgen23 = 4190 * 974.9 * t_o_vFlow .* (t_o_Ts3m1in - t_o_Ts3m3in);

t_o_Qgen = t_o_Qgen23 + t_o_Qgen6;
t_o_Egen = t_o_Egen_mod + t_o_Egen_mod23; 

% do straight eta_Qgen and eta_Egen
t_o_eta_Egen = t_o_Egen./t_o_GDN;
t_o_eta_Qgen = t_o_Qgen./t_o_GDN;

% calc uncertainty for Qgen
[s_Qgen_mod6] = UQ_Qgen(t_o_vFlow,t_o_Tin,t_o_Ts3m5in);
[s_Qgen_mod23] = UQ_Qgen(t_o_vFlow,t_o_Ts3m3in,t_o_Ts3m1in);
s_Qgen = sqrt( (s_Qgen_mod6).^2 + (s_Qgen_mod23).^2);

% calc uncertainty for eta_Qgen
[ s_eta_Qgen ] = UQ_eta_Qgen( t_o_Qgen, s_Qgen, t_o_GDN)

% calc uncertainty for eta_Egen (yes it uses the Qgen funct)
s_Egen = 0.73; % check BITCOPT1 appendix for value
[ s_eta_Egen ] = UQ_eta_Qgen( t_o_Egen, s_Egen, t_o_GDN)

% calc uncertainty for eta_Cgen
[t_o_eta_Cgen6, s_eta_Cgen_mod6] = UQ_eta_Cgen(t_o_Qgen6,s_Qgen_mod6,...
    t_o_Egen_mod,t_o_Gdn_mod);
[t_o_eta_Cgen23, s_eta_Cgen_mod23] = UQ_eta_Cgen(t_o_Qgen23,s_Qgen_mod23,...
    t_o_Egen_mod23,t_o_Gdn_mod23);

s_eta_Cgen = sqrt((2/3)^2.*(s_eta_Cgen_mod23).^2 + (1/3)^2.*(s_eta_Cgen_mod6).^2);
t_o_eta_Cgen = (2/3)*t_o_eta_Cgen23 + (1/3)*t_o_eta_Cgen6;

% % uncertainty for exergy
% [s_ex_epsilon_mod6,t_o_epsilon_mod6] = UQ_ex_epsilon(...
%     t_o_vFlow,t_s_Tref,t_o_Tin,t_o_Ts3m5in,t_o_Egen_mod,t_o_Gdn_mod,0.5);
% [s_ex_epsilon_mod23,t_o_epsilon_mod23] = UQ_ex_epsilon(...
%     t_o_vFlow,t_s_Tref,t_o_Ts3m3in,t_o_Ts3m1in,t_o_Egen_mod23,t_o_Gdn_mod23,0.5);
% 
% 
% % exergy:
% s_ex_epsilon =  sqrt( ((1/3)^2).* s_ex_epsilon_mod6.^2  + ((2/3)^2).* s_ex_epsilon_mod23.^2);
% t_o_epsilon = (t_o_epsilon_mod6 + 2.*t_o_epsilon_mod23 )./3;

%format error data to fit in the chart format
%error = 0.03.*ones(length(t_o_Tin(1:nthElement:end)'),1);
error_eta_Cgen       = s_eta_Cgen(1:nthElement:end);
error_eta_Qgen       = s_eta_Qgen(1:nthElement:end);
error_eta_Egen       = s_eta_Egen(1:nthElement:end);
error_eta_Cgen_mod23 = s_eta_Cgen_mod23(1:nthElement:end);
error_eta_Cgen_mod6  = s_eta_Cgen_mod6(1:nthElement:end);

% error_ex_mod23 = s_ex_epsilon_mod23(1:nthElement:end);
% error_ex = s_ex_epsilon(1:nthElement:end);
% error_ex = s_ex_epsilon(1:nthElement:end);
% error_ex_mod6 = s_ex_epsilon_mod6(1:nthElement:end);

%add the zero point
f=fit(t_o_Tin',t_o_eta_Cgen','poly1');
x=0:5:100;
y=f(x);

% plot(x,y,'LineStyle',':',...
%     'Color',Grey,...
%     'LineWidth',3);

% Graph Stuff
%build first error bar chart (Cgen)
%#delperdate
plot(t_o_Tin(1:nthElement:end)',t_o_eta_Cgen(1:nthElement:end)',...
    'Marker','o',...
    'MarkerSize',MarkerSize,...
    'LineWidth',LineWidthh,...
    'LineStyle','-',...
    'Color',Color_Cgen,...
    'MarkerFaceColor','w',...
    'MarkerEdgeColor',Color_Cgen,...
    'DisplayName','20-Feb eta Cogen, proto');
%     'DisplayName','20-Feb eta Cogen');

%#delperdate
plot(t_o_Tin(1:nthElement:end)',t_o_eta_Qgen(1:nthElement:end)',...
    'Marker','o',...
    'MarkerSize',MarkerSize,...
    'LineWidth',LineWidthh,...
    'LineStyle','-',...
    'Color',Color_Qgen,...
    'MarkerFaceColor','w',...
    'MarkerEdgeColor',Color_Qgen,...
    'DisplayName','20-Feb eta Qgen, proto');

%#delperdate
plot(t_o_Tin(1:nthElement:end)',t_o_eta_Egen(1:nthElement:end)',...
    'Marker','o',...
    'MarkerSize',MarkerSize,...
    'LineWidth',LineWidthh,...
    'LineStyle','-',...
    'Color',Color_Egen,...
    'MarkerFaceColor','w',...
    'MarkerEdgeColor',Color_Egen,...
    'DisplayName','20-Feb eta Egen, proto');

progress = 'measured plotted'
% end SPLICE

%% SPLICE Plot Feb 20th PROJECTED
%#delperdate
progress = 'plotting Feb20 PROJECTED'

load('PROJECTED_ICSolar.ICS_Skeleton_20_Feb_2015_v20180404.mat',...
    'chi_arrayTotal',...
    'dataset_Start','dataset_End','day',...
    'measured_T_HTFin', 'measured_T_cavAvg',...
    'G_DN_6mods',...
    'eta_Cgen_6mods',...
    'eta_Cgen_arrayTotal','eta_Egen_arrayTotal','eta_Qgen_arrayTotal',...
    'measured_eta_Cgen_arrayTotal','measured_Ex_epsilon','measured_Egen_arrayTotal',...
    'measured_Qgen_arrayTotal','measured_vFlow','measured_T_HTFout',...
    'GN_arrayTotal','measured_T_s3m5in','measured_T_s3m3in', 'measured_T_s3m1in');

% load('PROJECTED_ICSolar.ICS_Skeleton_20_Feb_2015_v20180404.mat',...
%     'chi_arrayTotal',...
%     'dataset_Start','dataset_End','day',...
%     'measured_T_HTFin','measured_T_cavAvg',...
%     'G_DN_6mods',...
%     'eta_Cgen_6mods', 'eta_Cgen_arrayTotal');

dataset_Start = 36 

% t_o_ = trim and groom the observed data into the right length for charting
t_o_vFlow = measured_vFlow(:,dataset_Start:dataset_End); 
%t_s_Tref = (T_ref+273).*ones(1,length(t_o_vFlow));

t_o_Tin =  measured_T_HTFin(:,dataset_Start:dataset_End) - 273;
t_o_Ts3m5in = measured_T_s3m5in(:,dataset_Start:dataset_End) - 273;
t_o_Ts3m3in = measured_T_s3m3in(:,dataset_Start:dataset_End) - 273;
t_o_Ts3m1in = measured_T_s3m1in(:,dataset_Start:dataset_End) - 273;

t_o_Gdn_mod = G_DN_6mods(:,dataset_Start:dataset_End)./6;
t_o_GDN = G_DN_6mods(:,dataset_Start:dataset_End)./6*3;
t_o_Egen_mod = measured_Egen_arrayTotal(:,dataset_Start:dataset_End)./6;
t_o_Gdn_mod23 = G_DN_6mods(:,dataset_Start:dataset_End)./3;
t_o_Egen_mod23 = measured_Egen_arrayTotal(:,dataset_Start:dataset_End)./3;
 
% calc how much Qgen and Egen
t_o_Qgen6 = 4190 * 974.9 * t_o_vFlow .* (t_o_Ts3m5in - t_o_Tin);
t_o_Qgen23 = 4190 * 974.9 * t_o_vFlow .* (t_o_Ts3m1in - t_o_Ts3m3in);

t_o_Qgen = t_o_Qgen23 + t_o_Qgen6;
t_o_Egen = t_o_Egen_mod + t_o_Egen_mod23; 

% do straight eta_Qgen and eta_Egen
t_o_eta_Egen = t_o_Egen./t_o_GDN;
t_o_eta_Qgen = t_o_Qgen./t_o_GDN;

% calc uncertainty for Qgen
[s_Qgen_mod6] = UQ_Qgen(t_o_vFlow,t_o_Tin,t_o_Ts3m5in);
[s_Qgen_mod23] = UQ_Qgen(t_o_vFlow,t_o_Ts3m3in,t_o_Ts3m1in);
s_Qgen = sqrt( (s_Qgen_mod6).^2 + (s_Qgen_mod23).^2);

% calc uncertainty for eta_Qgen
[ s_eta_Qgen ] = UQ_eta_Qgen( t_o_Qgen, s_Qgen, t_o_GDN)

% calc uncertainty for eta_Egen (yes it uses the Qgen funct)
s_Egen = 0.73; % check BITCOPT1 appendix for value
[ s_eta_Egen ] = UQ_eta_Qgen( t_o_Egen, s_Egen, t_o_GDN)

% calc uncertainty for eta_Cgen
[t_o_eta_Cgen6, s_eta_Cgen_mod6] = UQ_eta_Cgen(t_o_Qgen6,s_Qgen_mod6,...
    t_o_Egen_mod,t_o_Gdn_mod);
[t_o_eta_Cgen23, s_eta_Cgen_mod23] = UQ_eta_Cgen(t_o_Qgen23,s_Qgen_mod23,...
    t_o_Egen_mod23,t_o_Gdn_mod23);

s_eta_Cgen = sqrt((2/3)^2.*(s_eta_Cgen_mod23).^2 + (1/3)^2.*(s_eta_Cgen_mod6).^2);
t_o_eta_Cgen = (2/3)*t_o_eta_Cgen23 + (1/3)*t_o_eta_Cgen6;

t_o_eta_Cgen = eta_Cgen_arrayTotal(:,dataset_Start:dataset_End);
t_o_eta_Egen = eta_Egen_arrayTotal(:,dataset_Start:dataset_End);
t_o_eta_Qgen = eta_Qgen_arrayTotal(:,dataset_Start:dataset_End);

% % uncertainty for exergy
% [s_ex_epsilon_mod6,t_o_epsilon_mod6] = UQ_ex_epsilon(...
%     t_o_vFlow,t_s_Tref,t_o_Tin,t_o_Ts3m5in,t_o_Egen_mod,t_o_Gdn_mod,0.5);
% [s_ex_epsilon_mod23,t_o_epsilon_mod23] = UQ_ex_epsilon(...
%     t_o_vFlow,t_s_Tref,t_o_Ts3m3in,t_o_Ts3m1in,t_o_Egen_mod23,t_o_Gdn_mod23,0.5);
% 
% 
% % exergy:
% s_ex_epsilon =  sqrt( ((1/3)^2).* s_ex_epsilon_mod6.^2  + ((2/3)^2).* s_ex_epsilon_mod23.^2);
% t_o_epsilon = (t_o_epsilon_mod6 + 2.*t_o_epsilon_mod23 )./3;

%format error data to fit in the chart format
%error = 0.03.*ones(length(t_o_Tin(1:nthElement:end)'),1);
error_eta_Cgen       = s_eta_Cgen(1:nthElement:end);
error_eta_Qgen       = s_eta_Qgen(1:nthElement:end);
error_eta_Egen       = s_eta_Egen(1:nthElement:end);
error_eta_Cgen_mod23 = s_eta_Cgen_mod23(1:nthElement:end);
error_eta_Cgen_mod6  = s_eta_Cgen_mod6(1:nthElement:end);

% error_ex_mod23 = s_ex_epsilon_mod23(1:nthElement:end);
% error_ex = s_ex_epsilon(1:nthElement:end);
% error_ex = s_ex_epsilon(1:nthElement:end);
% error_ex_mod6 = s_ex_epsilon_mod6(1:nthElement:end);

%add the zero point
f=fit(t_o_Tin',t_o_eta_Cgen','poly1');
x=0:5:100;
y=f(x);

% plot(x,y,'LineStyle',':',...
%     'Color',Grey,...
%     'LineWidth',3);

%% plot feb20 PROJECTED

plot(t_o_Tin(1:nthElement:end)',t_o_eta_Cgen(1:nthElement:end)',...
    'Marker','o',...
    'MarkerSize',MarkerSize,...
    'LineWidth',LineWidthh,...
    'LineStyle','-',...
    'Color',Color_Cgen,...
    'MarkerFaceColor',Color_Cgen,...
    'MarkerEdgeColor',Color_Cgen,...
    'DisplayName','20-Feb eta Cogen,proj');
%     'DisplayName','20-Feb eta Cogen');

%#delperdate
plot(t_o_Tin(1:nthElement:end)',t_o_eta_Qgen(1:nthElement:end)',...
    'Marker','o',...
    'MarkerSize',MarkerSize,...
    'LineWidth',LineWidthh,...
    'LineStyle','-',...
    'Color',Color_Qgen,...
    'MarkerFaceColor',Color_Qgen,...
    'MarkerEdgeColor',Color_Qgen,...
    'DisplayName','20-Feb eta Qgen,proj');

%#delperdate
plot(t_o_Tin(1:nthElement:end)',t_o_eta_Egen(1:nthElement:end)',...
    'Marker','o',...
    'MarkerSize',MarkerSize,...
    'LineWidth',LineWidthh,...
    'LineStyle','-',...
    'Color',Color_Egen,...
    'MarkerFaceColor',Color_Egen,...
    'MarkerEdgeColor',Color_Egen,...
    'DisplayName','20-Feb eta Egen,proj');

progress = 'measured plotted'
% end SPLICE

%% Legending
legend('show');
set(legend,'FontName',FontNamee,...
    'Position', [0.45 0.1 0 0],...
    'Orientation','vertical',...
    'NumColumns',2,...
    'EdgeColor','none'...
    );
%     'Location','southoutside',...

progress = 'legend set'

%% save it out
filename = 'measured and Projected etas T_in - Whole Array for feb20';

savefig(filename);
% like this: print -painters -depsc output.eps 
print(filename,'-depsc');
% '-painters',
print(filename,'-dpng');

% https://www.mathworks.com/matlabcentral/answers/282750-is-there-a-way-to-save-the-figures-as-eps-files-using-legacy-behaviour-in-r2016a

progress = 'figs saved'
 %% fin
 
hold(axes1,'off');

%% graveyard 
 

%% Load PROJECTED 20 Feb
% 
% load('PROJECTED_ICSolar.ICS_Skeleton_20_Feb_2015_v20180404.mat',...
%     'chi_arrayTotal',...
%     'dataset_Start','dataset_End','day',...
%     'measured_T_HTFin','measured_T_cavAvg',...
%     'G_DN_6mods',...
%     'eta_Cgen_6mods', 'eta_Cgen_arrayTotal');
% 
% 
% Color = Color_Cgen;
% 
% t_o_Gdn = G_DN_6mods(:,dataset_Start:dataset_End);
% t_o_Tin =  measured_T_HTFin(:,dataset_Start:dataset_End) - 273;
% t_o_Tcav = measured_T_cavAvg(:,dataset_Start:dataset_End);
% delta_T = t_o_Tin - t_o_Tcav;
% t_o_eta = eta_Cgen_arrayTotal(:,dataset_Start:dataset_End);
% 
% t_o_Tin =  measured_T_HTFin(:,dataset_Start:dataset_End) - 273;
% t_o_Ts3m5in = measured_T_s3m5in(:,dataset_Start:dataset_End) - 273;
% t_o_Ts3m3in = measured_T_s3m3in(:,dataset_Start:dataset_End) - 273;
% t_o_Ts3m1in = measured_T_s3m1in(:,dataset_Start:dataset_End) - 273;
% 
% t_o_Gdn_mod = G_DN_6mods(:,dataset_Start:dataset_End)./6;
% t_o_Egen_mod = measured_Egen_arrayTotal(:,dataset_Start:dataset_End)./6;
% t_o_Gdn_mod23 = G_DN_6mods(:,dataset_Start:dataset_End)./3;
% t_o_Egen_mod23 = measured_Egen_arrayTotal(:,dataset_Start:dataset_End)./3;
%  
% t_o_Qgen6 = 4190 * 974.9 * t_o_vFlow .* (t_o_Ts3m5in - t_o_Tin);
% t_o_Qgen23 = 4190 * 974.9 * t_o_vFlow .* (t_o_Ts3m1in - t_o_Ts3m3in);
% 
% t_o_Qgen = t_o_Qgen23 + t_o_Qgen6;
% t_o_Egen = t_o_Egen_mod + t_o_Egen_mod23; 
% 
% progress = "feb20 projected loaded"
% 
 %% Plot PROJECTED 20 Feb
% 
% % scatter(t_o_Tin(1:nthElement:end)',t_o_epsilon(1:nthElement:end)',...
% %     'MarkerSize',...
% %     'MarkerFaceColor',Color,...
% %     'MarkerEdgeColor',Color,...
% %     'Marker','o',...
% %     'DisplayName','Projected \epsilon');
% % 
% % f=fit(t_o_Tin',t_o_eta','poly1');
% % x=0:5:100;
% % y=f(x);
% % 
% % plot(x,y,'LineStyle',':',...
% %     'Color',Color,...
% %     'LineWidth',3);
% % 
% 
% % 'MarkerSize',MarkerSize,...
% scatter(t_o_Tin(1:nthElement:end)',t_o_eta(1:nthElement:end)',...
%     ScatterMarkerSize,...
%     'MarkerFaceColor',Color_Cgen,...
%     'MarkerEdgeColor',Color_Cgen,...
%     'Marker','o',...
%     'DisplayName','Projected eta Cogen');
% 
% scatter(t_o_Tin(1:nthElement:end)',t_o_eta(1:nthElement:end)',...
%     ScatterMarkerSize,...
%     'MarkerFaceColor',Color_Cgen,...
%     'MarkerEdgeColor',Color_Cgen,...
%     'Marker','o',...
%     'DisplayName','Projected eta Cogen');
% 
% T_HTFin = t_o_Tin;
% % % predict_eps = t_o_epsilon;
% % predict_eta = t_o_eta_Cgen;
% % 
% % f=fit(T_HTFin',predict_eta','poly2');
% % x=0:5:100;
% % y=f(x);
% % indexmax = find(max(y) == y);
% % xmax_2 = x(indexmax);
% % ymax_2 = y(indexmax);
% % 
% % plot(x,y,'LineStyle',':',...
% %     'DisplayName','Extrapolated Modeled Results',...
% %     'Color',Color,...
% %     'LineWidth',3);
% % 
% % 
% % % PREDICTION
% % Color = Yellowish;
% % % 1.5 ml/s
% % predict_chi = [0.006, 0.025, 0.053, 0.08, 0.11];
% % T_HTFin = [40 50 60 70 80];
% % predict_eta = [0.3771 0.3833 0.3864 0.3867 0.384];
% % 
% % % f=fit(T_HTFin',predict_eta','poly2');
% % % x=0:5:100;
% % % y=f(x);
% % % 
% % % plot(x,y,'LineStyle',':',...
% % %     'DisplayName','Modeled Fit',...
% % %     'Color',Color,...
% % %     'LineWidth',3);
% % 
% % % indexmax = find(max(y) == y);
% % % xmax = x(indexmax);
% % % ymax = y(indexmax);
% % % 
% % % strmax = ['Maximum = ',num2str(xmax)];
% % % text(xmax,ymax,strmax,'VerticalAlignment','top');
% % % 
% % 
% % %3 ml/s
% % predict_chi = [0, 0.086, 0.17];
% % predict_eta = [0.1324, 0.1485, 0.123];
% % 
% % 
% % f=fit(predict_chi',predict_eta','poly2');
% % x=0:.01:.2;
% % y=f(x);
% 
% % plot(x,y,'LineStyle','--',...
% %     'DisplayName','3 ml/s Fit',...
% %     'Color',Color,...
% %     'LineWidth',3);
% progress = "feb20 projected plotted"
