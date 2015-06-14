%%PLOT THE ENERGY OUTPUT (measured & modeled) 

%Make sure the Start and End values are set as save in the .mat file

% view data to determine start and ends of collection period

%trimmed observed 
t_o_Egen = measured_Egen_arrayTotal(:,Start:End);
t_o_Qgen = measured_Qgen_arrayTotal(:,Start:End); 

%trimmed simulated
t_s_Egen = Egen_arrayTotal(:,Start:End); 
t_s_Qgen = Qgen_arrayTotal(:,Start:End); 

%trimmed time
t_time = time(:,Start:End);


%%--PLOT ENERGY GENERATION

figure
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

title({strcat(day,': Array Total Energy Generation'),'6 Modules of PV & 12 Modules of Thermal Collection'});

axis([0 360 0 100])
%Create xlabel
xlabel('Time (minutes)');
set(gca,'XTickLabel',{'0','15','30','45','60'}); 
set(gca,'XTick',[0 90 190 270 360]);
% Create ylabel
ylabel('Power (Watts)');

legend('Measured Qgen','Modeled Qgen','Measured Egen','Modeled Egen','Location','southeast');  

filename = strcat(day,' Energy'); 
savefig(filename);
hold off;




%%--PLOT MODELED EFFICIENCY


%%Plots the Eta (only modeled)
%trimmed simulated
t_s_eta_Egen = eta_Egen_mods(:,Start:End); 
t_s_eta_Qgen = eta_Qgen_mods(:,Start:End); 
t_s_eta_Com = t_s_eta_Qgen + t_s_eta_Egen;

figure
hold on;


% Plot Heat
plot(t_s_eta_Qgen,'LineStyle',':','Color',[1 0 0],'DisplayName','eta Qgen','LineWidth',2);

% Plot Eletrical
plot(t_s_eta_Egen,'LineStyle',':',...
    'Color',[0.494117647409439 0.184313729405403 0.556862771511078],...
    'DisplayName','eta Egen','LineWidth',2);
% Plot COmbined
plot(t_s_eta_Com,'LineStyle',':','Color',[0 0 1],'DisplayName','eta Combined','LineWidth',2);

title({strcat(day,': Array Efficiency'),'6 Modules of PV & 12 Modules of Thermal Collection'});

axis([0 360 0 0.7])
% Create xlabel
xlabel('Time (minutes)');
set(gca,'XTickLabel',{'0','15','30','45','60'}); 
set(gca,'XTick',[0 90 190 270 360]);

% Create ylabel
ylabel('Effciency (module conversion efficiency)');

legend('eta Qgen','eta Egen','eta Combined','Location','northeast');  

filename = strcat(day,' Eta'); 
savefig(filename);
%% Plot chi vs eta_CGen


figure;
hold on;

t_o_chi = chi_arrayTotal(:,Start:End);
t_o_eta_Cgen_arrayTotal = measured_eta_Cgen_arrayTotal(:,Start:End);

chi_trans = transpose(t_o_chi);
eta_Cgen_trans = transpose(t_o_eta_Cgen_arrayTotal);

f=fit(chi_trans,eta_Cgen_trans,'poly1');

scatter(chi_trans,eta_Cgen_trans,'Marker','.','DisplayName','Chi vs Eta');

title({strcat(day,': \chi vs \eta_{Q + E gen}'),'Whole Array Total'});
xlabel('\chi = (T_{in} - T_{cav}) / (G_{DN} / 12 modules * A_{POE})');
ylabel('\eta_{Q + E gen} = Q_{gen} + E_{gen} / (G_{DN Array Total})');
x=0:.01:.1;
y=f(x);

axis([0 0.14 0 0.8])

plot(x,y,'LineStyle',':','DisplayName','Linear Bestfit');

legend('show');

filename = strcat(day,' Chi'); 
savefig(filename);



