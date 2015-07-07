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

%trimmed observed .. trimed_observed
t_o_Egen = measured_Egen_arrayTotal(:,Start:End);
t_o_Qgen = measured_Qgen_arrayTotal(:,Start:End); 
t_o_vFlow = measured_vFlow(:,Start:End); 
t_o_Tin = measured_T_HTFin(:,Start:End); 
t_o_Tout = measured_T_HTFout(:,Start:End); 

%trimmed simulated
t_s_Egen = Egen_arrayTotal(:,Start:End); 
t_s_Qgen = Qgen_arrayTotal(:,Start:End); 

%trimmed time
t_time = time(:,Start:End);


%%--PLOT ENERGY GENERATION

%figure
figure('Color',[1 1 1]);
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

% For Thermal
fill([x,fliplr(x)],[y1,fliplr(y2)],Grey,'FaceAlpha',0.15,'LineStyle','--',...
    'EdgeColor',Grey);    

% plot(s_Qgen_upper,'Color',Grey,'LineStyle',':','LineWidth',2);
% plot(s_Qgen_lower,'Color',Grey,'LineStyle',':','LineWidth',2);
% plot(s_Egen_upper,'Color',Grey,'LineStyle',':','LineWidth',2);
% plot(s_Egen_lower,'Color',Grey,'LineStyle',':','LineWidth',2);




%fill(X,Y,'red','FaceAlpha',0.2); 

title({strcat(day,': Array Total Energy Generation'),...
    '6 Modules of PV & 12 Modules of Thermal Collection'},...
    'FontName','Arial Narrow',...
    'FontSize',18);

axis([0 360 0 100])
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

legend('Measured Q_{gen}','Modeled Q_{gen}','Measured E_{gen}',...
    'Modeled E_{gen}','Uncertainity','Location','eastoutside');    %'southeast'
set(legend,'FontName','Arial Narrow');




filename = strcat(day,' Energy'); 
savefig(filename);
print(filename,'-dpng');
hold off;





%% --PLOT MODELED EFFICIENCY


%%Plots the Eta (only modeled)
%trimmed simulated
t_s_eta_Egen = eta_Egen_mods(:,Start:End); 
t_s_eta_Qgen = eta_Qgen_mods(:,Start:End); 
t_s_eta_Com = t_s_eta_Qgen + t_s_eta_Egen;

figure('Color',[1 1 1]);
hold on;


% Plot Heat
plot(t_s_eta_Qgen,'LineStyle',':','Color',[1 0 0],'DisplayName','eta Qgen','LineWidth',2);

% Plot Eletrical
plot(t_s_eta_Egen,'LineStyle',':',...
    'Color',[0.301960796117783 0.745098054409027 0.933333337306976],...
    'DisplayName','eta Egen','LineWidth',2);
% Plot COmbined
plot(t_s_eta_Com,'LineStyle',':','Color',[0.494117647409439 0.184313729405403 0.556862771511078],'DisplayName','eta Combined','LineWidth',2);

title({strcat(day,': Modeled Array Efficiency'),'6 Modules of PV & 12 Modules of Thermal Collection'},'FontName','Arial Narrow');

axis([0 360 0 0.7])
% Create xlabel
xlabel('Time (minutes)','FontName','Arial Narrow');
set(gca,'XTickLabel',{'0','15','30','45','60'}); 
set(gca,'XTick',[0 90 190 270 360]);
set(gca,'XGrid','on');
% Create ylabel
ylabel('\eta (module conversion efficiency)','FontName','Arial Narrow');
set(gca,'YGrid','on');
legend('\eta Q_{gen}','\eta E_{gen}','\eta Combined','Location','northeast');  
set(legend,'FontName','Arial Narrow');

filename = strcat(day,' Eta'); 
savefig(filename);
print(filename,'-dpng');

%% Plot chi vs eta_CGen


figure('Color',[1 1 1]);
hold on;

t_o_chi = chi_arrayTotal(:,Start:End);
t_o_eta_Cgen_arrayTotal = measured_eta_Cgen_arrayTotal(:,Start:End);

chi_trans = transpose(t_o_chi);
eta_Cgen_trans = transpose(t_o_eta_Cgen_arrayTotal);

f=fit(chi_trans,eta_Cgen_trans,'poly1');

scatter(chi_trans,eta_Cgen_trans,'Marker','.','DisplayName','\chi vs \eta combined');

title({strcat(day,' \chi vs \eta combined'),'Measured Total Array'},'FontName','Arial Narrow');
xlabel('\chi = (T_{HTF,in} - T_{cav}) / (G_{DN} / 12 modules * A_{POE})','FontName','Arial Narrow');
set(gca,'XGrid','on');

ylabel('\eta combined = Q_{gen} + E_{gen} / (G_{DN Array Total})','FontName','Arial Narrow');
set(gca,'YGrid','on');

x=0:.01:.2;
y=f(x);

axis([0 0.14 0 0.8])

plot(x,y,'LineStyle',':','DisplayName','Linear Bestfit');

legend('show');
set(legend,'FontName','Arial Narrow');

filename = strcat(day,' Chi'); 
savefig(filename);
print(filename,'-dpng');

