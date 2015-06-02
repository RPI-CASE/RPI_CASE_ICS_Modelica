%%Trim and Post process solar data


% view data to determine start and ends of collection period
Start = 90;
End = 117;

%trimmed simulated
t_s_eta_Egen = eta_E(:,Start:End); 
t_s_eta_Qgen = eta_Q(:,Start:End); 
t_s_eta_Com = t_s_eta_Qgen + t_s_eta_Egen;

hold on;
% Plot Heat
plot(t_s_eta_Qgen,'LineStyle',':','Color',[1 0 0],'DisplayName','eta Qgen','LineWidth',2);

% Plot Eletrical
plot(t_s_eta_Egen,'LineStyle',':',...
    'Color',[0.494117647409439 0.184313729405403 0.556862771511078],...
    'DisplayName','eta Egen','LineWidth',2);
% Plot COmbined
plot(t_s_eta_Com,'LineStyle',':','Color',[0 0 1],'DisplayName','eta Combined','LineWidth',2);

title({'23 March 2015: Array Efficiency','6 Modules of PV & 12 Modules of Thermal Collection'},...
    'FontWeight','bold',...
    'FontSize',16);

axis([0 30 0 0.7])
% Create xlabel
xlabel('Time (minutes)','FontSize',16);
set(gca,'XTickLabel',{'0','','','30','','','60'},'FontSize',16); 

% Create ylabel
ylabel('Effciency)','FontSize',16);

legend('eta Qgen','eta Egen','eta Combined','Location','northeast');  

figure1 = figure('Color',[1 1 1]);
