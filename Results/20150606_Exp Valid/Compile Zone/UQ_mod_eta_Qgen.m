%% Function compute the UQ for the measured eta Q Gen

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


[s_Qgen_mod6] = UQ_Qgen(t_o_vFlow,t_o_Tin,t_o_Ts3m5in);
[s_Qgen_mod23] = UQ_Qgen(t_o_vFlow,t_o_Ts3m3in,t_o_Ts3m1in);



%[s_ex_epsilon_mod6,t_o_epsilon_mod6] = UQ_ex_epsilon(...
%    t_o_vFlow,t_s_Tref,t_o_Tin,t_o_Ts3m5in,t_o_Egen_mod,t_o_Gdn_mod,0.5);

%[s_ex_epsilon_mod23,t_o_epsilon_mod23] = UQ_ex_epsilon(...
%    t_o_vFlow,t_s_Tref,t_o_Ts3m3in,t_o_Ts3m1in,t_o_Egen_mod23,t_o_Gdn_mod23,1);


%s_ex_epsilon =  sqrt( ((1/3)^2).* s_ex_epsilon_mod6.^2  + ((2/3)^2).* s_ex_epsilon_mod23.^2);

%t_o_epsilon = (t_o_epsilon_mod6 + 2.*t_o_epsilon_mod23 )./3;

s_Qgen = sqrt( (s_Qgen_mod6).^2 + (s_Qgen_mod23).^2);

t_o_Qgen6 = 4190 * 974.9 * t_o_vFlow .* (t_o_Ts3m5in - t_o_Tin);
t_o_Qgen23 = 4190 * 974.9 * t_o_vFlow .* (t_o_Ts3m1in - t_o_Ts3m3in);
t_o_Qgen = t_o_Qgen23 + t_o_Qgen6;

[s_eta_Qgen_mod6] = UQ_eta_Qgen(t_o_Qgen6,s_Qgen_mod6,t_o_Gdn_mod);
[s_eta_Qgen_mod23] = UQ_eta_Qgen(t_o_Qgen23,s_Qgen_mod23,t_o_Gdn_mod23);

s_eta_Qgen = sqrt((2/3)^2.*(s_eta_Qgen_mod23).^2 + (1/3)^2.*(s_eta_Qgen_mod6).^2);

t_o_eta_Qgen6 = t_o_Qgen6 ./t_o_Gdn_mod;
t_o_eta_Qgen23 = t_o_Qgen23 ./t_o_Gdn_mod23;
t_o_eta_Qgen = (t_o_Qgen6 + t_o_Qgen23) ./ (t_o_Gdn_mod + t_o_Gdn_mod23);


per_err_1 = mean (s_eta_Qgen_mod6./t_o_eta_Qgen6);
per_err_2 = mean (s_eta_Qgen_mod23./t_o_eta_Qgen23);
per_err = mean (s_eta_Qgen./t_o_eta_Qgen);



upper =  t_o_eta_Qgen + s_eta_Qgen;
lower = t_o_eta_Qgen - s_eta_Qgen;


figure;
hold on;

plot(t_o_eta_Qgen);
plot(lower);
plot(upper);






