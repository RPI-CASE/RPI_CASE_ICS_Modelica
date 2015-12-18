%% Function compute the UQ for the measured Ex Epsilon

clear all;

T_ref = 20; % (c)


load('ICSolar.ICS_Skeleton_20_Feb_2015_v5.mat','chi_arrayTotal',...
    'Start','End','day','measured_T_HTFin',...
    'measured_T_cavAvg','G_DN_6mods','eta_Cgen_6mods',...
    'measured_eta_Cgen_arrayTotal','measured_Ex_epsilon','measured_Egen_arrayTotal',...
    'measured_Qgen_arrayTotal','measured_vFlow','measured_T_HTFout',...
    'GN_arrayTotal','measured_T_s3m5in','measured_T_s3m3in', 'measured_T_s3m1in');

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


[s_ex_epsilon_mod6,t_o_epsilon_mod6] = UQ_ex_epsilon(...
    t_o_vFlow,t_s_Tref,t_o_Tin,t_o_Ts3m5in,t_o_Egen_mod,t_o_Gdn_mod,0.5);

[s_ex_epsilon_mod23,t_o_epsilon_mod23] = UQ_ex_epsilon(...
    t_o_vFlow,t_s_Tref,t_o_Ts3m3in,t_o_Ts3m1in,t_o_Egen_mod23,t_o_Gdn_mod23,1);


s_ex_epsilon =  sqrt( ((1/3)^2).* s_ex_epsilon_mod6.^2  + ((2/3)^2).* s_ex_epsilon_mod23.^2);

t_o_epsilon = (t_o_epsilon_mod6 + 2.*t_o_epsilon_mod23 )./3;

upper = t_o_epsilon + s_ex_epsilon;
lower = t_o_epsilon - s_ex_epsilon;


figure;
hold on;

plot(t_o_epsilon);
plot(lower);
plot(upper);






