%%Trim and Post process solar data


% view data to determine start and ends of collection period
Start = 90;
End = 117;

%trimmed observed 
t_o_Egen = measured_Egen(:,Start:End);
t_o_Qgen = measured_Qgen(:,Start:End); 

%trimmed simulated
t_s_Egen = Egen_arrayTotal(:,Start:End); 
t_s_Qgen = Qgen_arrayTotal(:,Start:End); 

%trimmed time
t_time = time(:,Start:End);

hold on;

% Plot Heat
plot(t_o_Qgen,'Color',[1 0 0],'DisplayName','t_o_Qgen','LineWidth',2);
plot(t_s_Qgen,'LineStyle',':','Color',[1 0 0],'DisplayName','t_s_Qgen','LineWidth',2);

% Plot Eletrical
plot(t_o_Egen,'Color',[0.494117647409439 0.184313729405403 0.556862771511078],...
    'DisplayName','t_o_Egen','LineWidth',2);
plot(t_s_Egen,'LineStyle',':',...
    'Color',[0.494117647409439 0.184313729405403 0.556862771511078],...
    'DisplayName','t_s_Egen','LineWidth',2);

title({'23 March 2015: Array Total Energy Generation','6 Modules of PV & 12 Modules of Thermal Collection'});

axis([0 30 0 100])
% Create xlabel
xlabel('Time (minutes)');
set(gca,'XTickLabel',{'0','','','30','','','60'}); 

% Create ylabel
ylabel('Power (Watts)');

legend('Measured Qgen','Modeled Qgen','Measured Egen','Modeled Egen','Location','southeast');  