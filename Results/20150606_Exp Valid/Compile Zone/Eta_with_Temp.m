%% --PLOT MODELED EFFICIENCY
% view data to determine start and ends of collection period
Turquoise = [0.301960796117783 0.745098054409027 0.933333337306976];
Purple = [0.494117647409439 0.184313729405403 0.556862771511078];
Grey = [0.7 0.7 0.7];
Orange = [0.85 0.33 0.1];

%%Plots the Eta (only modeled)
%trimmed simulated
t_s_eta_Egen = eta_Egen_mods(:,Start:End); 
t_s_eta_Qgen = eta_Qgen_mods(:,Start:End); 
t_s_eta_Com = t_s_eta_Qgen + t_s_eta_Egen;
t_o_Tin = measured_T_HTFin(:,Start:End) - 273; 
x = 1:length(t_s_eta_Egen);


figure('Color',[1 1 1],'Position', [100, 100, 1049, 895]);
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
    'LineWidth',3);

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
    'FontWeight','bold'); 
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
ylabel(Ax(2),sprintf('T_{in} (%cC) ',char(176)));


% 
% % Create ylabel
% set(gca,'YGrid','on',...
%     'FontName','arial narrow',...
%     'FontSize',18,...
%     'FontWeight','bold');

% Create Legend
legend('\eta Q_{gen}','\eta E_{gen}','\eta Combined',...
    'Location','southoutside',...
    'Orientation','horizontal'); % northeast
set(legend,'FontName','Arial Narrow');

filename = strcat(day,' Eta'); 
savefig(filename);
print(filename,'-dpng');