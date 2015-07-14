%% --PLOT GDN AND TEMP
%trimmed observed .. trimed_observed
t_o_Tin = measured_T_HTFin(:,Start:End) - 273; 
 
%trimmed simulated
t_s_Gdn = GN_arrayTotal(:,Start:End);

x = 1:length(t_o_Tin);

[Ax,h1,h2] = plotyy(x,t_s_Gdn,x,t_o_Tin);

title('G_{DNI} and Inlet Temperature');

set(Ax(1),'ylim',[300 400]);
ylabel(Ax(1),'G_{DNI}'); % left y-axis

set(Ax(2),'ylim',[50 100]);
ylabel(Ax(2),'Temperature'); % right y-axis

