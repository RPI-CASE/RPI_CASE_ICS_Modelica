% Chart out homogeneous (3module) eta vs T_HTFin
% begat: back circa 2015
% authors: Kenton Phillips, Nick Novelli
% Changelog
% 20180330 reconfigured to output just etas since exergy is left out of
% results
clear all; %needs to be before any other variable calls

nthElement = 50; %reduce the number of output datapoints on chart
%for exergy uncertainty (c)
% T_ref = 20

%%figure out some colors

Blueish = [0 0.45 0.74];
Yellowish = [0.75 0.75 0];
Redish = [0.85 0.33 0.1];
Grey = [.5 .5 .5];
Color_Cgen = [75/255,0/255,130/255]; %purple
Color_Egen = [0 0.45 0.74];
Color_Qgen = [0.9 0.0 0.0] ;


%% get single figure going
figure('Color',[1 1 1]);
% hold on;

MarkerSize = 5;
LineWidth = 0.8;


% Create axes
axes1 = axes;
hold(axes1,'on');

% title({'\chi vs \epsilon','Measured Total Array'},...
%     'FontSize',18,...
%     'FontName','Arial Narrow');

% xlabel('T_{HTF,in}(°C)','FontWeight','bold','FontName','arial narrow');
  xlabel('T_{HTF,in}','FontWeight','bold','FontName','arial narrow');
set(gca,'XGrid','on',...
    'FontName','arial narrow',...
    'FontSize',12,...
    'FontWeight','bold');

%ylabel('\epsilon_{Cogen and eta Cogen',...
ylabel('Efficiency (eta Egen, eta Qgen, eta Cogen)',...
    'FontName','Arial Narrow',...
    'FontSize',12,...
    'FontWeight','bold');
set(gca,'YGrid','on',...
    'FontName','arial narrow',...
    'FontSize',12,...
    'FontWeight','bold');

% Uncomment the following line to preserve the X-limits of the axes
% xlim(axes1,[50 90]);
% Uncomment the following line to preserve the Y-limits of the axes
% ylim(axes1,[0 0.801]);

axis([50 90 0 0.801]);

set(axes1,'FontName','arial narrow','FontWeight','bold','OuterPosition',...
    [0 0.2098341856499 1 0.7901658143501],'XGrid','on','XTick',...
    [50 55 60 65 70 75 80 85 90],'XTickLabel',...
    {'50°C','','60°C','','70°C','','80°C','','90°C'},'YGrid','on','YTick',...
    [0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8]);


%% Plot Feb 20th
%#delperdate
onToPlotFeb20 = 1

load('ICSolar.ICS_Skeleton_20_Feb_2015_v20180330.mat','chi_arrayTotal',...
    'dataset_Start','dataset_End','day','measured_T_HTFin',...
    'measured_T_cavAvg','G_DN_6mods','eta_Cgen_6mods',...
    'measured_eta_Cgen_arrayTotal','measured_Ex_epsilon','measured_Egen_arrayTotal',...
    'measured_Qgen_arrayTotal','measured_vFlow','measured_T_HTFout',...
    'GN_arrayTotal','measured_T_s3m5in','measured_T_s3m3in', 'measured_T_s3m1in')


dataset_Start = 36 %#delperdate
% Modeled
Color = Grey;
Color = Blueish;

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
errorbar(t_o_Tin(1:nthElement:end)',t_o_eta_Cgen(1:nthElement:end)',error_eta_Cgen,...
    'Marker','o',...
    'MarkerSize',MarkerSize,...
    'LineWidth',LineWidth,...
    'LineStyle','-',...
    'Color',Color_Cgen,...
    'MarkerFaceColor','w',...
    'MarkerEdgeColor',Color_Cgen,...
    'DisplayName','20-Feb eta Cogen');
%     'DisplayName','20-Feb eta Cogen');

%#delperdate
errorbar(t_o_Tin(1:nthElement:end)',t_o_eta_Qgen(1:nthElement:end)',error_eta_Qgen,...
    'Marker','o',...
    'MarkerSize',MarkerSize,...
    'LineWidth',LineWidth,...
    'LineStyle','-',...
    'Color',Color_Qgen,...
    'MarkerFaceColor','w',...
    'MarkerEdgeColor',Color_Qgen,...
    'DisplayName','20-Feb eta Qgen');

%#delperdate
errorbar(t_o_Tin(1:nthElement:end)',t_o_eta_Egen(1:nthElement:end)',error_eta_Egen,...
    'Marker','o',...
    'MarkerSize',MarkerSize,...
    'LineWidth',LineWidth,...
    'LineStyle','-',...
    'Color',Color_Egen,...
    'MarkerFaceColor','w',...
    'MarkerEdgeColor',Color_Egen,...
    'DisplayName','20-Feb eta Egen');

 %% Plot Mar 19th
%#delperdate
onToPlotMar19 = 1

load('ICSolar.ICS_Skeleton_19_Mar_2015_v20180330.mat','chi_arrayTotal',...
    'dataset_Start','dataset_End','day','measured_T_HTFin',...
    'measured_T_cavAvg','G_DN_6mods','eta_Cgen_6mods',...
    'measured_eta_Cgen_arrayTotal','measured_Ex_epsilon','measured_Egen_arrayTotal',...
    'measured_Qgen_arrayTotal','measured_vFlow','measured_T_HTFout',...
    'GN_arrayTotal','measured_T_s3m5in','measured_T_s3m3in', 'measured_T_s3m1in')

%dataset_Start = 36 %#delperdate
% Modeled
Color = Grey;
Color = Blueish;

% t_o_ = trim and groom the observed data into the right length for charting
t_o_vFlow = measured_vFlow(:,dataset_Start:dataset_End); 
% t_s_Tref = (T_ref+273).*ones(1,length(t_o_vFlow));

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
errorbar(t_o_Tin(1:nthElement:end)',t_o_eta_Cgen(1:nthElement:end)',error_eta_Cgen,...
    'Marker','v',...
    'MarkerSize',MarkerSize,...
    'LineWidth',LineWidth,...
    'LineStyle','-',...
    'Color',Color_Cgen,...
    'MarkerFaceColor','w',...
    'MarkerEdgeColor',Color_Cgen,...
    'DisplayName','19-Mar eta Cogen');

%#delperdate
errorbar(t_o_Tin(1:nthElement:end)',t_o_eta_Qgen(1:nthElement:end)',error_eta_Qgen,...
    'Marker','v',...
    'MarkerSize',MarkerSize,...
    'LineWidth',LineWidth,...
    'LineStyle','-',...
    'Color',Color_Qgen,...
    'MarkerFaceColor','w',...
    'MarkerEdgeColor',Color_Qgen,...
    'DisplayName','19-Mar eta Qgen');

%#delperdate
errorbar(t_o_Tin(1:nthElement:end)',t_o_eta_Egen(1:nthElement:end)',error_eta_Egen,...
    'Marker','v',...
    'MarkerSize',MarkerSize,...
    'LineWidth',LineWidth,...
    'LineStyle','-',...
    'Color',Color_Egen,...
    'MarkerFaceColor','w',...
    'MarkerEdgeColor',Color_Egen,...
    'DisplayName','19-Mar eta Egen');

 %% Plot 23-Mar
%#delperdate
load('ICSolar.ICS_Skeleton_23_Mar_2015_v20180330.mat','chi_arrayTotal',...
    'dataset_Start','dataset_End','day','measured_T_HTFin',...
    'measured_T_cavAvg','G_DN_6mods','eta_Cgen_6mods',...
    'measured_eta_Cgen_arrayTotal','measured_Ex_epsilon','measured_Egen_arrayTotal',...
    'measured_Qgen_arrayTotal','measured_vFlow','measured_T_HTFout',...
    'GN_arrayTotal','measured_T_s3m5in','measured_T_s3m3in', 'measured_T_s3m1in')

%dataset_Start = 36 %#delperdate
% Modeled
Color = Grey;
Color = Blueish;

% t_o_ = trim and groom the observed data into the right length for charting
t_o_vFlow = measured_vFlow(:,dataset_Start:dataset_End); 
% t_s_Tref = (T_ref+273).*ones(1,length(t_o_vFlow));

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
errorbar(t_o_Tin(1:nthElement:end)',t_o_eta_Cgen(1:nthElement:end)',error_eta_Cgen,...
    'Marker','^',...
    'MarkerSize',MarkerSize,...
    'LineWidth',LineWidth,...
    'LineStyle','-',...
    'Color',Color_Cgen,...
    'MarkerFaceColor','w',...
    'MarkerEdgeColor',Color_Cgen,...
    'DisplayName','23-Mar eta Cogen');

%#delperdate
errorbar(t_o_Tin(1:nthElement:end)',t_o_eta_Qgen(1:nthElement:end)',error_eta_Qgen,...
    'Marker','^',...
    'MarkerSize',MarkerSize,...
    'LineWidth',LineWidth,...
    'LineStyle','-',...
    'Color',Color_Qgen,...
    'MarkerFaceColor','w',...
    'MarkerEdgeColor',Color_Qgen,...
    'DisplayName','23-Mar eta Qgen');

%#delperdate
errorbar(t_o_Tin(1:nthElement:end)',t_o_eta_Egen(1:nthElement:end)',error_eta_Egen,...
    'Marker','^',...
    'MarkerSize',MarkerSize,...
    'LineWidth',LineWidth,...
    'LineStyle','-',...
    'Color',Color_Egen,...
    'MarkerFaceColor','w',...
    'MarkerEdgeColor',Color_Egen,...
    'DisplayName','23-Mar eta Egen');

%% Legending
legend('show');
set(legend,'FontName','Arial Narrow',...
    'Location','southoutside',...
    'Orientation','vertical',...
    'NumColumns',3);



%% save file
filename = 'etas vs T_HTFin - Whole Array for 3 datasets';
savefig(filename);
% like this: print -painters -depsc output.eps 
% print(filename,'-depsc');
% '-painters',
print(filename,'-dpng');

% https://www.mathworks.com/matlabcentral/answers/282750-is-there-a-way-to-save-the-figures-as-eps-files-using-legacy-behaviour-in-r2016a

 %% fin
 
hold(axes1,'off');

