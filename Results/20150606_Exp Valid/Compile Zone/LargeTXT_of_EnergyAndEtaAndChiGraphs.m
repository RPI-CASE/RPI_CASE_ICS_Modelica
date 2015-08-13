%% This file creates charts for the energy, eta, and chi values from a .mat
% file has been processed to have a start and end time (steady-state
% region)

% the 3 charts are then saved in the folder as matlab Figs.


%%PLOT THE ENERGY OUTPUT (measured & modeled) 

%Make sure the Start and End values are set as save in the .mat file

%color code
% turq / cyan [0.301960796117783 0.745098054409027 0.933333337306976]
% purple [0.494117647409439 0.184313729405403 0.556862771511078]

% view data to determine start and ends of collection period
Turquoise = [0.301960796117783 0.745098054409027 0.933333337306976];
Purple = [0.494117647409439 0.184313729405403 0.556862771511078];
Grey = [0.7 0.7 0.7];

big = 16;
little = 16;
legendFont = 16;



%trimmed observed .. trimed_observed
t_o_Egen = measured_Egen_arrayTotal(:,Start:End);
t_o_Qgen = measured_Qgen_arrayTotal(:,Start:End); 
t_o_vFlow = measured_vFlow(:,Start:End); 
t_o_Tin = measured_T_HTFin(:,Start:End); 
t_o_Tout = measured_T_HTFout(:,Start:End); 
 

%trimmed simulated
t_s_Egen = Egen_arrayTotal(:,Start:End); 
t_s_Qgen = Qgen_arrayTotal(:,Start:End); 
t_s_Gdn = GN_arrayTotal(:,Start:End);


%trimmed time
t_time = time(:,Start:End);


%%--PLOT ENERGY GENERATION

%figure
%figure('Color',[1 1 1],'Position', [100, 100, 1049, 895]);
figure('Color',[1 1 1],'Position', [100, 50, 600, 900]);
s_1 = subplot(2,1,2);
hold on;

% Plot Heat
plot(t_o_Qgen,'Color',[1 0 0],'DisplayName','t_o_Qgen','LineWidth',2);

plot(t_s_Qgen,'LineStyle','--','Color',[1 0 0],'DisplayName','t_s_Qgen','LineWidth',2);

% Plot Eletrical
plot(t_o_Egen,'Color',Turquoise,...
    'DisplayName','t_o_Egen','LineWidth',2);
plot(t_s_Egen,'LineStyle','--',...
    'Color',Turquoise,...
    'DisplayName','t_s_Egen','LineWidth',2);

% Plot UQ
s_Egen = 0.73; % please refer to UQ calcs in 'UQ_24-May-15_v1_KP.xlsx'
s_Qgen = UQ_Qgen(t_o_vFlow,t_o_Tin,t_o_Tout);
%s_Qgen = 10;


% Creat Upper and Lower Limits
s_Qgen_upper = t_o_Qgen + s_Qgen;
s_Qgen_lower = t_o_Qgen - s_Qgen;

s_Egen_upper = t_o_Egen + s_Egen;
s_Egen_lower = t_o_Egen - s_Egen;

% Create Fill between lines
x = 1:length(t_o_Qgen);
y1 = s_Qgen_lower;
y2 = s_Qgen_upper;

% For Thermal
fill([x,fliplr(x)],[y1,fliplr(y2)],Grey,'FaceAlpha',0.15,'LineStyle','--',...
    'EdgeColor',Grey);    

% Create Fill between lines
y1 = s_Egen_lower;
y2 = s_Egen_upper;

% For Electrical
fill([x,fliplr(x)],[y1,fliplr(y2)],Grey,'FaceAlpha',0.15,'LineStyle','--',...
   'EdgeColor',Grey);


% plot(s_Qgen_upper,'Color',Grey,'LineStyle',':','LineWidth',2);
% plot(s_Qgen_lower,'Color',Grey,'LineStyle',':','LineWidth',2);
% plot(s_Egen_upper,'Color',Grey,'LineStyle',':','LineWidth',2);
% plot(s_Egen_lower,'Color',Grey,'LineStyle',':','LineWidth',2);

% title({strcat(day,': Array Total Energy Generation'),...
%     '6 Modules of PV & 12 Modules of Thermal Collection'},...
%     'FontName','Arial Narrow',...
%     'FontSize',18);

axis([0 360 0 100]);

%BreakPlot(x,t_s_Gdn,100,350,'Patch');

% title(day,...
%     'FontName','Arial Narrow',...
%     'FontSize',18);

%Create xlabel
xlabel('Time (minutes)',...
    'FontName','Arial Narrow',...
    'FontSize',big,... % 15.4
    'FontWeight','bold');
set(gca,'XTickLabel',{'0','15','30','45','60'},...
    'FontName','arial narrow',...
    'FontSize',little,... % 14
    'FontWeight','bold'); 
set(gca,'XTick',[0 90 180 270 360]);
set(gca,'XGrid','on');
set(gca,'Position',[0.12 0.05 0.75 0.53]);



% Create ylabel
ylabel('Power (Watts)',...
    'FontName','Arial Narrow',...
    'FontSize',big,...
    'FontWeight','bold');
set(gca,'YGrid','on',...
    'FontName','arial narrow',...
    'FontSize',little,...
    'FontWeight','bold');

legend('Measured Q_{gen}','Modeled Q_{gen}','Measured E_{gen}',...
    'Modeled E_{gen}','Uncertainty',...
    'Location','southoutside',...
    'Orientation','horizontal');    %'southeast'
set(legend,'FontName','Arial Narrow',...
    'FontSize',legendFont);

hold off;


% Make top Testing Conditions Plot

subplot(2,1,1);
hold on;

% 2 y axes plot
[Ax,h1,h2] = plotyy(x,t_s_Gdn,x,t_o_Tin-273);

set(h1,'LineStyle',':');
set(h2,'LineStyle','-.');

title(day,...
    'FontName','Arial Narrow',...
    'FontSize',big);

ylim(Ax(1),[300 450]);
xlim(Ax(1),[0 360]);
ylabel(Ax(1),'G_{DN} (Watts)'); % left y-axis

ylim(Ax(2),[50 100]);
xlim(Ax(2),[0 360]);
ylabel(Ax(2),sprintf('T_{in} (%cC) ',char(176))); % right y-axis

set(Ax(1),'Position',[0.12 0.71 0.75 0.24]);
set(Ax(1),'YTick',[300 350 400 450]);
set(Ax(1),'YGrid','on');
set(Ax(2),'Position',[0.12 0.71 0.75 0.24]);
set(Ax(2),'FontName','arial narrow',...
    'FontSize',big,... % 14
    'FontWeight','bold');
set(Ax(2),'YTick',[50 60 70 80 90 100]);
set(Ax(2),'YGrid','on');

set(Ax(1),'XTickLabel',{'0','15','30','45','60'},...
    'FontName','arial narrow',...
    'FontSize',big,... % 14
    'FontWeight','bold');

set(Ax(1),'XTick',[0 90 180 270 360]);
set(Ax(1),'XGrid','on');


h1.LineWidth = 2;
h2.LineWidth = 2;


legend('G_{DN}','T_{in}',...
    'Location','southoutside',...
    'Orientation','horizontal');    %'southeast'
set(legend,'FontName','Arial Narrow')




filename = strcat(day,' Energy'); 
savefig(filename);
%print(filename,'-dpng');

hold off;





%% --PLOT MODELED EFFICIENCY
% view data to determine start and ends of collection period
Turquoise = [0.301960796117783 0.745098054409027 0.933333337306976];
Purple = [0.494117647409439 0.184313729405403 0.556862771511078];
Grey = [0.7 0.7 0.7];
Orange = [0.85 0.33 0.1];

%%Plots the Eta (only modeled)
%trimmed simulated
t_s_eta_Egen = eta_Egen_6mods(:,Start:End); 
t_s_eta_Qgen = eta_Qgen_6mods(:,Start:End); 
t_s_eta_Com = eta_Cgen_6mods(:,Start:End); 
t_o_Tin = measured_T_HTFin(:,Start:End) - 273; 
x = 1:length(t_s_eta_Egen);


figure('Color',[1 1 1],'Position', [100, 100, 500, 500]);
hold on;

% Plot ALL
[Ax,H1,H2]=plotyy(x,[t_s_eta_Qgen' t_s_eta_Egen' t_s_eta_Com'],x,t_o_Tin);

% Set Qgen Properties
set(H1(1),'Color',[1 0 0 ],...
    'LineStyle',':',...
    'LineWidth',3);

% Set Egen Properties
set(H1(2),'Color',Turquoise,...
    'LineStyle',':',...
    'LineWidth',3);

% Set Cgen Properties
set(H1(3),'Color',Purple,...
    'LineStyle',':',...
    'LineWidth',3);

% Set Temp Properties
set(H2,'Color',Orange,...
    'LineWidth',3,...
    'LineStyle','-.');

% % title({strcat(day,': Modeled Module Collection Efficiency'),...
% %     '6 Modules of PV & Thermal Collection'},...
% %     'FontName','Arial Narrow',...
%     'FontSize',18);
 title(day,...
    'FontName','Arial Narrow',...
    'FontSize',18);
 
axis([0 360 0 0.8])


xlabel('Time (minutes)',...
    'FontName','Arial Narrow',...
    'FontSize',20,... % 15.4
    'FontWeight','bold');
ylabel(Ax(1),'\eta_{(module conversion efficiency)}',...
   'FontName','Arial Narrow',...
    'FontSize',20,...
    'FontWeight','bold');
    



set(gca,'XTickLabel',{'0','15','30','45','60'},...
    'FontName','arial narrow',...
    'FontSize',18,... % 14
    'FontWeight','bold',...
    'Position',[0.15 0.05 0.68 0.87]); 
set(gca,'XTick',[0 90 180 270 360]);
set(gca,'YTick',[0:0.1:08]);
set(gca,'YGrid','on');
set(gca,'XGrid','on');

ylim(Ax(2),[50 100]);
xlim(Ax(2),[0 360]);
set(Ax(2),'XTick',[0 90 180 270 360],...
    'YTick',[50 60 70 80 90 100],...
    'YGrid','on',...
    'ycolor',Orange,...
    'FontName','arial narrow',...
    'FontSize',18,... % 14
    'FontWeight','bold');    
ylabel(Ax(2),sprintf('T_{HTF,in} (%cC) ',char(176)));


% 
% % Create ylabel
% set(gca,'YGrid','on',...
%     'FontName','arial narrow',...
%     'FontSize',18,...
%     'FontWeight','bold');

% Create Legend
legend('\eta Q_{gen}','\eta E_{gen}','\eta Combined','T_{HTF,IN}',...
    'Location','southoutside',...
    'Orientation','horizontal'); % northeast
set(legend,'FontName','Arial Narrow');

filename = strcat(day,' Eta'); 
savefig(filename);
print(filename,'-dpng');

%% Plot chi vs eta_CGen

figure('Color',[1 1 1],'Position', [100, 100, 1049, 895]);
hold on;

t_o_chi = chi_arrayTotal(:,Start:End);
t_o_eta_Cgen_arrayTotal = measured_eta_Cgen_arrayTotal(:,Start:End);

chi_trans = transpose(t_o_chi);
eta_Cgen_trans = transpose(t_o_eta_Cgen_arrayTotal);

f=fit(chi_trans,eta_Cgen_trans,'poly1');

scatter(chi_trans,eta_Cgen_trans,...
    'MarkerFaceColor',[0 0.45 0.74],...
    'DisplayName','\chi vs \eta_{combined}');

% title({strcat(day,' \chi vs \eta_{Combined}'),'Measured Total Array'},...
%     'FontName','Arial Narrow',...
%     'FontSize',18);
 title(day,...
    'FontName','Arial Narrow',...
    'FontSize',18);

xlabel(strcat('\chi',sprintf('(%cC m^2 / W)',char(176))),...
    'FontName','Arial Narrow',...
     'FontSize',20,...
    'FontWeight','bold');
set(gca,'XTick',[0 0.03 0.06 0.09 0.12]);
set(gca,'XGrid','on');

ylabel('\eta_{Combined}',...
    'FontName','Arial Narrow',...
    'FontSize',20,...
    'FontWeight','bold');
set(gca,'YGrid','on',...
    'FontName','arial narrow',...
    'FontSize',18,...
    'FontWeight','bold');

x=0:.01:.2;
y=f(x);

axis([0 0.14 0 0.8])

plot(x,y,'LineStyle',':',...
    'DisplayName','Linear Bestfit',...
    'Color',[0 0.45 0.74],...
    'LineWidth',3);

legend('show');
set(legend,'FontName','Arial Narrow',...
    'Location','southoutside',...
    'Orientation','horizontal'); % northeast

filename = strcat(day,' Chi'); 
savefig(filename);
%print(filename,'-dpng');


