function [ s_ex_epsilon_out,ex_epsilon_out] = UQ_ex_epilsion(V_dot_in, T0_in,T1_in, T2_in, Egen_in, Gdn_in)
%UQ_ex_epsilon returns the error in the epsilon calculation
%   UQ_ex_epilsion(V_dot_in, T0_in,T1_in, T2_in, Egen_in, Gdn_in)

syms  ex_thermal exergy_thermal ex_epsilon V_dot cp rho T0 T1 T2 Egen Gdn Psi;
syms  s_ex_thermal s_exergy_thermal s_ex_epsilon s_V_dot s_cp s_rho s_T0 s_T1 s_T2 s_Egen s_Gdn s_Psi;

ex_thermal(V_dot,cp,rho,T0,T1,T2)= V_dot*cp*rho* (T2 - T1 - T0 * log(T2/T1));
ex_epsilon(exergy_thermal,Egen,Gdn,Psi) = (exergy_thermal + Egen) / (Gdn*Psi);

s_ex_thermal(V_dot,cp,rho,T0,T1,T2,s_V_dot,s_cp,s_rho,s_T0,s_T1,s_T2)= sqrt(...
    diff(ex_thermal,V_dot)^2 * s_V_dot^2 + diff(ex_thermal,cp)^2 * s_cp^2 + ...
    diff(ex_thermal,rho)^2 * s_rho^2 + diff(ex_thermal,T0)^2 * s_T0^2 + ...
    diff(ex_thermal,T1)^2 * s_T1^2 + diff(ex_thermal,T2)^2 * s_T2^2);

s_ex_epsilon(exergy_thermal,Egen,Gdn,Psi,s_exergy_thermal,s_Egen,s_Gdn,s_Psi) = sqrt(...
    diff(ex_epsilon,exergy_thermal)^2 * s_exergy_thermal^2 + diff(ex_epsilon,Egen)^2 * s_Egen^2 + ...
    diff(ex_epsilon,Gdn)^2 * s_Gdn^2 + diff(ex_epsilon,Psi) * s_Psi ^2);


% % INIT values
cp_in = 4190;
rho_in = 974.9;
Psi_in = 0.93;
T1_in = T1_in + 273;
T2_in = T2_in + 273;
%INIT Uncertainlty values
s_Egen_in = 0.73;
s_Gdn_in = 10;
%INIT Uncertainlty values
s_V_dot_in = (3.5e-06)*0.05;
s_T1_in = 0.5;
s_T2_in = 0.5;
%s_T0_in = 0.5;
s_T0_in = 0; 
s_cp_in =  cp_in*(1/100);
s_rho_in = rho_in*(1/100);
s_Psi_in = 0; %place holder if we want to change


%  evaluate the symbolic expressions
exergy_thermal_in = double(ex_thermal(V_dot_in,cp_in,rho_in,T0_in,T1_in,T2_in));

s_exergy_thermal_in = double(s_ex_thermal(V_dot_in,cp_in,rho_in,T0_in,T1_in,T2_in,...
    s_V_dot_in,s_cp_in,s_rho_in,s_T0_in,s_T1_in,s_T2_in));

ex_epsilon_out = double(ex_epsilon(exergy_thermal_in,Egen_in,Gdn_in,Psi_in));

s_ex_epsilon_out = double(s_ex_epsilon(exergy_thermal_in,Egen_in,Gdn_in,Psi_in,...
    s_exergy_thermal_in,s_Egen_in,s_Gdn_in,s_Psi_in));
end

 